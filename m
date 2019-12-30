Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3040612CFF0
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 13:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfL3MWu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 07:22:50 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:25550 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfL3MWu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 07:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577708569; x=1609244569;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SABsUx1T1jSoGqJORYPDibJGPM+X6pZmzZHfIRFddbE=;
  b=QzYcOjr7tFPGNgKgTujMq5YOWVIWrrpCREGR7crNOteAZhBM3bD4tRhE
   yrfnixTIrvNvTBwH8EI3MCbEziS68/5YJqekaQeo2mRAga65n8YZ4wdaZ
   QCXkkuv1tfCG6IiYNOoivmmbjedX7UUftZECL2zP/8+4RLFk3oBjIa7j7
   E=;
IronPort-SDR: 9LFYe89JaB2Br1uX48QJCwdd1keF5E8n5djbe5kamHgQX8mbsejbrTT0p0zo5hdicpYsRyfW8y
 z2w2xHzJ/gpQ==
X-IronPort-AV: E=Sophos;i="5.69,375,1571702400"; 
   d="scan'208";a="9545906"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 30 Dec 2019 12:22:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 09753A1CCA;
        Mon, 30 Dec 2019 12:22:45 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Dec 2019 12:22:45 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.155) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Dec 2019 12:22:39 +0000
Subject: Re: [PATCH v6 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS
 modules
To:     Jack Wang <jinpuwang@gmail.com>
CC:     <linux-block@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <axboe@kernel.dk>, <hch@infradead.org>, <sagi@grimberg.me>,
        <bvanassche@acm.org>, <leon@kernel.org>, <dledford@redhat.com>,
        <danil.kipnis@cloud.ionos.com>, <jinpu.wang@cloud.ionos.com>,
        <rpenyaev@suse.de>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-26-jinpuwang@gmail.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9b923988-acb3-9a44-255f-47da7609d225@amazon.com>
Date:   Mon, 30 Dec 2019 14:22:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191230102942.18395-26-jinpuwang@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.155]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 30/12/2019 12:29, Jack Wang wrote:
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
> index e09bd92a1e44..2ba370d8145d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14125,6 +14125,13 @@ F:	arch/riscv/
>  K:	riscv
>  N:	riscv
>  
> +RNBD BLOCK DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-block@vger.kernel.org
> +S:	Maintained
> +F:	drivers/block/rnbd/
> +
>  ROCCAT DRIVERS
>  M:	Stefan Achatz <erazor_de@users.sourceforge.net>
>  W:	http://sourceforge.net/projects/roccat/
> @@ -14192,6 +14199,13 @@ F:	include/net/rose.h
>  F:	include/uapi/linux/rose.h
>  F:	net/rose/
>  
> +RTRS TRANSPORT DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-rdma@vger.kernel.org
> +S:	Maintained
> +F:	drivers/infiniband/ulp/rtrs/
> +
>  RTL2830 MEDIA DRIVER
>  M:	Antti Palosaari <crope@iki.fi>
>  L:	linux-media@vger.kernel.org

RTRS should be after RTL, right :)?
