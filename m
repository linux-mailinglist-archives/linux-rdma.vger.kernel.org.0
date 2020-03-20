Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DF18D9B1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTUtf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 16:49:35 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41999 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTUtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 16:49:35 -0400
Received: by mail-wr1-f41.google.com with SMTP id v11so9105894wrm.9
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 13:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odGQ2hQgXyuroa90B5vjBwZ7z7ei2Hr/GxAMeid1ZH8=;
        b=lKvzSj9yvv2clWwsGhHWlYGe282Nd2TidEgaAZy36vXT9DuGWnVf7AJrEY3vvrtxFT
         9ecQbR/TewPb+jLGV4/7QV7nhnA83xiTh9PrnbvufHwQmiER7ToC0+XdL0ab43oAq7Hg
         q3QwPDSqS5IKv5E/2b3dc8Lkrpru3IsjsU33jhc4BfwBUhn2KXljjUlDs7M8rDLqyRRr
         jZqlyuvqtduqr8ifJVOjRDn5DZSpJl8FlJ7A237imEjovSilciE88mxRewujtcLENsJ5
         /5HEEZR4XOqBVOznQHKBmm4FYV8tjaHZYfmBpWmlUYLw+Xs5lBo/CwuNqbLHHIATcReP
         CCrA==
X-Gm-Message-State: ANhLgQ18faUs2SNh97ovYIG7wxtjBNUdlyleesxiNY8PjVmsscIY1Uos
        EJD0lDlbIOSm8ulLALhYcTE=
X-Google-Smtp-Source: ADFU+vvPCN8W93w/UXwiY5NIerSxTt+y669GCRGqUK+Jar3v1M3uTqBgmF5GSDgm6wMkIsTDRpBM0A==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr5140930wrm.26.1584737371342;
        Fri, 20 Mar 2020 13:49:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b9e4:7d48:9c27:2b02? ([2601:647:4802:9070:b9e4:7d48:9c27:2b02])
        by smtp.gmail.com with ESMTPSA id f9sm9883254wrc.71.2020.03.20.13.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2020 13:49:30 -0700 (PDT)
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
 <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
 <20200317203152.GA14946@chelsio.com>
 <3f42f881-0309-b86a-4b70-af23c58960fc@grimberg.me>
 <20200320143544.GA5539@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <87bfe03d-baad-1166-14a1-6eba1739fde4@grimberg.me>
Date:   Fri, 20 Mar 2020 13:49:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200320143544.GA5539@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> I assume this happens with iSCSI as well? There is nothing special
>> we are doing with respect to digest.
> 
> I don't see this issue with iscsi-tcp.
> 
> May be blk-mq is causing this issue? I assume iscsi-tcp does not have
> blk_mq support yet upstream to verify with blk_mq enabled.
> I tried on Ubuntu 19.10(which is based on Linux kernel 5.3), note that
> RHEL does not support DataDigest.
> 
> The reason that I'm seeing this issue only with NVMe(tcp/softiwarp) &
> iSER(softiwarp) is becuase of NVMeF&ISER using blk-mq?
> 
> Anyhow, I see the content of the page is being updated by upper layers
> while the tranport driver is computing CRC on that page content and
> this needs a fix.

Krishna, do you happen to run with nvme multipath enabled?
