Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE6B28FE
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 01:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbfIMX4v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Sep 2019 19:56:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42716 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390733AbfIMX4v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Sep 2019 19:56:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so2874531pls.9;
        Fri, 13 Sep 2019 16:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MtiCWUtWty1s4gu4Rj0cFnzrGW+hIk1x87XErhTQ9tc=;
        b=cM5MfFu9ae1pZvGlDFzCcLN39xA+yZrA1+axrEqSHHmnPVRuyWiwspfbYh3Dc5vAS9
         UrcfzxVED6E/kEZIWrXjoq2xFi1iHgGAZVbnlF58q/0c4BQC466Jim5zzfkJLG8zaW8Y
         TLo+rFXaDtOIYz/jAHKfPDccA1jrtNXQnT9VOPMRrBzriVshv0HZBKtKeQYfgL09VR9Y
         WexrWyH3O/9fdt+VgAcjU81SUMYsmFSiRucFQ7dZ14c/O92fqsRJmqSeVRcIBrl+c2q2
         1ZffhSyJdbdNoe92eRoJLTl90AKWVJgOFH/iIlKw7j1N2Cxta6HhGnKrSuKPyWZaJXIp
         Yqzw==
X-Gm-Message-State: APjAAAX6srSk7eDPqXSASfoM10+DJUZvUL5wwnO6QHx1PATMMtTpVWdM
        aMoN+qVWJ4Qsl1KyaKrz1ZM=
X-Google-Smtp-Source: APXvYqwF58RKWN/Hin1z6Ws45pml8vtNsZgxXcQW430fKsIIoS2CTOXblMlJLbqyIitdq2z7tcj7TQ==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr48677656plq.342.1568419008990;
        Fri, 13 Sep 2019 16:56:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b6sm24529787pgq.26.2019.09.13.16.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 16:56:47 -0700 (PDT)
Subject: Re: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS
 modules
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-26-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <79f11a21-3d4f-96de-113c-1b77734ac428@acm.org>
Date:   Fri, 13 Sep 2019 16:56:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-26-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> From: Roman Pen <roman.penyaev@profitbricks.com>
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>   MAINTAINERS | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6954776a37e..0b7fd93f738d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
>   S:	Orphan
>   F:	drivers/scsi/ips.*
>   
> +IBNBD BLOCK DRIVERS
> +M:	IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> +L:	linux-block@vger.kernel.org
> +S:	Maintained
> +T:	git git://github.com/profitbricks/ibnbd.git
> +F:	drivers/block/ibnbd/
> +
> +IBTRS TRANSPORT DRIVERS
> +M:	IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> +L:	linux-rdma@vger.kernel.org
> +S:	Maintained
> +T:	git git://github.com/profitbricks/ibnbd.git
> +F:	drivers/infiniband/ulp/ibtrs/
> +
>   ICH LPC AND GPIO DRIVER
>   M:	Peter Tyser <ptyser@xes-inc.com>
>   S:	Maintained

I think the T: entry is for kernel trees against which developers should 
prepare their patches. Since the ibnbd repository on github is an 
out-of-tree kernel driver I don't think that it should appear in the 
MAINTAINERS file.

Bart.


