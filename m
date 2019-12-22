Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F31E128D4E
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Dec 2019 10:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfLVJz5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Dec 2019 04:55:57 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:37840 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfLVJz5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Dec 2019 04:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577008557; x=1608544557;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PQaCvMfCuUkb4obaMNLy41XcTzJJl4DCmYthC5eEva8=;
  b=QfQseYNxSLSOi+mSWFMRC15YkSW4/60vuc/MqYwqDLE2X6H1LoF7Foqj
   aa3WUdixRIdW2zIfaEkpL7MvwnZJsEs/1+QhrwX5f9WJMaznj13ZGNESu
   EnilhB1yqp0EogmyMxO+kxRWOFOxFlqUmyzS17n2ynIvovFj4rdADPunJ
   o=;
IronPort-SDR: 4hfUXlMPWlK69DeSAnYsond1taW9vclHnuW1SLALZw+DuyaoCzqBMa+4xjs9dR1k0U3w6JZVC7
 GZn1FVZj78lw==
X-IronPort-AV: E=Sophos;i="5.69,343,1571702400"; 
   d="scan'208";a="10187789"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Dec 2019 09:55:56 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id D1F0F2833CE;
        Sun, 22 Dec 2019 09:55:51 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Sun, 22 Dec 2019 09:55:51 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Dec 2019 09:55:33 +0000
Subject: Re: [PATCH v5 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS
 modules
To:     Jack Wang <jinpuwang@gmail.com>, <linux-block@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@infradead.org>, <sagi@grimberg.me>,
        <bvanassche@acm.org>, <leon@kernel.org>, <dledford@redhat.com>,
        <danil.kipnis@cloud.ionos.com>, <jinpu.wang@cloud.ionos.com>,
        <rpenyaev@suse.de>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
 <20191220155109.8959-26-jinpuwang@gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <655f25d2-7c3f-989a-0aa4-9f8f72c63c6b@amazon.com>
Date:   Sun, 22 Dec 2019 11:55:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191220155109.8959-26-jinpuwang@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D31UWA001.ant.amazon.com (10.43.160.57) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/12/2019 17:51, Jack Wang wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> Danil and me will maintain RNBD/RTRS modules.
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc0a4a8ae06a..e0caeac43fc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7955,6 +7955,20 @@ IBM ServeRAID RAID DRIVER
>  S:	Orphan
>  F:	drivers/scsi/ips.*
>  
> +RNBD BLOCK DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-block@vger.kernel.org
> +S:	Maintained
> +F:	drivers/block/rnbd/
> +
> +RTRS TRANSPORT DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-rdma@vger.kernel.org
> +S:	Maintained
> +F:	drivers/infiniband/ulp/rtrs/
> +
>  ICH LPC AND GPIO DRIVER
>  M:	Peter Tyser <ptyser@xes-inc.com>
>  S:	Maintained
> 

Entries should be added in alphabetical order.
