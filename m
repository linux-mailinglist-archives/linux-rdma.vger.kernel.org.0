Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A3388CD6
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbhESLb6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 07:31:58 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:49100 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhESLb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 May 2021 07:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1621423839; x=1652959839;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ieAMlp0e92WQWZAvsoX/ywDjpd8as1Xa1upk2S4udvo=;
  b=FovU9ogloGmcdmDK/jEwP6DLWQiTQwp27T0CajNJP+zMbPb49zDP6ZFk
   ZzGgTHWa+or0oWBaXUb0urVAoy3VPim+6QBAgJfjIl/VhvvCs0PkzU5lf
   s8LJzMJgHtEw9oKThS4g93hdF17Js9tnNOktwazDcrQ5eKDhLjcKS7l3b
   w=;
X-IronPort-AV: E=Sophos;i="5.82,312,1613433600"; 
   d="scan'208";a="110235358"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 19 May 2021 11:30:32 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id 9BA08C0578;
        Wed, 19 May 2021 11:30:25 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.253) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Wed, 19 May 2021 11:30:17 +0000
Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2cdd5b33-1e54-779b-53b4-054d734b5eb2@amazon.com>
Date:   Wed, 19 May 2021 14:29:57 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D42UWA001.ant.amazon.com (10.43.160.153) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 17/05/2021 19:47, Jason Gunthorpe wrote:
> +struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev)
> +{
> +	/*
> +	 * It is probably a bug that efa reports its port stats as device
> +	 * stats
> +	 */

Hmm, yea this needs some work.
Most of these stats are in fact port stats, but others (admin commands,
keep-alive, allocation/creation error) are device stats.

You can split them if you wish, or I can send a followup patch.

Thanks,
Tested-by: Gal Pressman <galpress@amazon.com>
