Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992D265B47
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfGKQNp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 12:13:45 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42195 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGKQNo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 12:13:44 -0400
Received: by mail-pf1-f180.google.com with SMTP id q10so2971929pff.9
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 09:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cL/X5NWFWdpnoYati0e4ynEWFOKwvnTNd7do68BUFSI=;
        b=IPQdPzoK1xVzj8Yk3AhpYboRDlLmFDXMKHTjb5PJXxLAzKbuEmXcOmN5czhqSYlyfr
         UqUgyfysflLUbd8bx14dbsR072Hz748tlgkAPpl0bGk8PVY7LljXp9N9YIQrwl6BOcuQ
         fMrNLD8LTHgMYwo80YU6kQH/XLqCST3accTh9jKj7I9IQNofMCUYIB3p9UBUhBK4eYIz
         MQpNvBksrb/eLX/DQfp/40XDWrZqnkd0uZQjdCkiTPmHUzXmDA9xG1F/h7yo11qDNXI5
         U/5QBmS4iSba955VOHqUf9VgSy0Q09ooKiPuq8fdv6odGmyqmzZtgiJhtwpEUVnESv2+
         pl/w==
X-Gm-Message-State: APjAAAWunOV8ospm+mkB9j7LdkSmYaFewFPOIISj+iTzwOSyL2lgjUxG
        KPBXhUsM5RA4pCC2F3/YlsC6YnFY
X-Google-Smtp-Source: APXvYqyovg84n56ALe90eTRcaqvHSGjGsiS1t6ROazoXWQqOeQYdKCgb+X3Tp9zfcZNO+iOAcaLIeA==
X-Received: by 2002:a63:c508:: with SMTP id f8mr5384491pgd.48.1562861623638;
        Thu, 11 Jul 2019 09:13:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:10a0:43d6:25f7:7bc3? ([2601:647:4800:973f:10a0:43d6:25f7:7bc3])
        by smtp.gmail.com with ESMTPSA id a10sm5093314pgq.2.2019.07.11.09.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 09:13:42 -0700 (PDT)
Subject: Re: regression: nvme rdma with bnxt_re0 broken
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
Cc:     danielj@mellanox.com, parav@mellanox.com,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <648e86db-864f-9eb1-5275-564a1ef535fb@grimberg.me>
Date:   Thu, 11 Jul 2019 09:13:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

CC linux-rdma

On 7/11/19 2:47 AM, Yi Zhang wrote:
> Hello
> 
> 'nvme connect' failed when use bnxt_re0 on latest upstream build[1], by bisecting I found it was introduced from v5.2.0-rc1 with [2], it works after I revert it.
> Let me know if you need more info, thanks.
> 
> [1]
> [root@rdma-perf-07 ~]$ nvme connect -t rdma -a 172.31.40.125 -s 4420 -n testnqn
> Failed to write to /dev/nvme-fabrics: Bad address
> 
> [root@rdma-perf-07 ~]$ dmesg
> [  476.320742] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x4b9]=0x15 status 0x5
> [  476.327103] infiniband bnxt_re0: Failed to allocate HW AH
> [  476.332525] nvme nvme2: rdma_connect failed (-14).
> [  476.343552] nvme nvme2: rdma connection establishment failed (-14)
> 
> [root@rdma-perf-07 ~]$ lspci  | grep -i Broadcom
> 01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720 2-port Gigabit Ethernet PCIe
> 01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720 2-port Gigabit Ethernet PCIe
> 18:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
> 19:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> 19:00.1 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> 
> 
> [2]
> commit 823b23da71132b80d9f41ab667c68b112455f3b6
> Author: Parav Pandit <parav@mellanox.com>
> Date:   Wed Apr 10 11:23:03 2019 +0300
> 
>      IB/core: Allow vlan link local address based RoCE GIDs
>      
>      IPv6 link local address for a VLAN netdevice has nothing to do with its
>      resemblance with the default GID, because VLAN link local GID is in
>      different layer 2 domain.
>      
>      Now that RoCE MAD packet processing and route resolution consider the
>      right GID index, there is no need for an unnecessary check which prevents
>      the addition of vlan based IPv6 link local GIDs.
>      
>      Signed-off-by: Parav Pandit <parav@mellanox.com>
>      Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
>      Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>      Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> 
> 
> Best Regards,
>    Yi Zhang
> 
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
