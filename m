Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5E34453F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhCVNOF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 09:14:05 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:7998 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhCVNLu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 09:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1616418709; x=1647954709;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zOwbymHIq1hP9KuK7H4nChZsMNjtDojKcxzsEmxBCBE=;
  b=rFkYVdRSMk79dWWeFOQctb4WQmOyGioHrPfjx7Ejpt2VcCo+iETHZpMl
   8/oyBOPeZA7fZzHIu9TTXwrLmlY+qmDm0KrY2BGDUb4dXRopfIcKA3izj
   PFQacyAr9Fjq46+R6k8f6HxRqpJDN4xiRppxDxO1BJKMTLk7X0TwC2QuR
   U=;
X-IronPort-AV: E=Sophos;i="5.81,268,1610409600"; 
   d="scan'208";a="920615495"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 22 Mar 2021 13:11:41 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id B30C6A071B;
        Mon, 22 Mar 2021 13:11:40 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.55) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 22 Mar 2021 13:11:37 +0000
Subject: Re: [PATCH for-next] RDMA/efa: Use strscpy instead of strlcpy
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210316132416.83578-1-galpress@amazon.com>
 <20210322130131.GC247894@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <fd35f82a-abd8-ff53-d8d2-0e401ec92ea0@amazon.com>
Date:   Mon, 22 Mar 2021 15:11:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322130131.GC247894@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.55]
X-ClientProxiedBy: EX13P01UWA004.ant.amazon.com (10.43.160.127) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 22/03/2021 15:01, Jason Gunthorpe wrote:
> On Tue, Mar 16, 2021 at 03:24:16PM +0200, Gal Pressman wrote:
>> The strlcpy function doesn't limit the source length, use the preferred
>> strscpy function instead.
> 
> Why do we need to limit the source length here? Either this is a bug
> because the source string is no NULL terminated or it is OK as is?

It's not a bug as is, but it addresses checkpatch's warning:
WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
