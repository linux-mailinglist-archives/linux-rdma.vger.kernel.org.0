Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF08493C35
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 15:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355276AbiASOtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 09:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355273AbiASOtZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 09:49:25 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A2C06173E
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 06:49:24 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id q14so2462617qtx.10
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ebj2v9aauSthzIYWo7QMYbJ7+f74Bs+InfheCepxYQ=;
        b=UyBhcZyqV06Q+lerX33fodCKzbbo6UN21015hA1XzKQSN3/aDtkNZraQJqfTwrgQ9E
         iJyEonr90tPHETmsWEVeKf5Fiv0ZY9Ojvum3iYQNo3dQBI+vbNsEig6xG0RhmLGyVv2L
         A1eqnTBh4sxStbn7+6lmoo08j6xFIC7A5VQ07TpM83Xbae6snqjRS2y/vJtxEFOMS2M4
         fktALHxE9fdS245d+fE6q7SWGXuhk8AJoFyibv2SC06N8v2e8bZy14soeOh1AwK8s2Dd
         Qsflu8/pNW1JTBjN1A2W1xETT7Mhbp3igJF3HCSz7nrkfQhlTavAnt9VAMYvq7eLstHa
         Y+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ebj2v9aauSthzIYWo7QMYbJ7+f74Bs+InfheCepxYQ=;
        b=MFFGM07KSzK8/2NPuhQRvrv8ptrztfn7HjCe7wF6Kn9zCOjxpKfblH1THYZz2MDstM
         e1Ajt8YShOek0jcNirl1WttoPVFYn6wOChs0LuQcwbfO3vN9nP+MvMQn+2sMdIVhnSqL
         +yqqfCbLIKJjvX/1BeS6Fh0IRX3B4WvRYsuJN8+erGzdVPBdpAEEEYa9bWlD9I24vaQg
         10dKp5WYo0heIr7k817DBwLXXN1DdKiIQvzqHtJSgbpcrkZYrRLdIVmsgU6jQ4yLeXKY
         RP/MXgDwOxGGjMzbUAfX6xXBPHQEnPR7XHGANbbCYj8ETVKDpzGoAli6m9gnewb0aFwd
         WJBA==
X-Gm-Message-State: AOAM530adi6SJdSl0bz2pSIv2nvtWCEPDcr6VfmbyqRXSkCvFz0PplNW
        35tg/EGW2C0HzpaqOtMdS48yGw==
X-Google-Smtp-Source: ABdhPJwXjosarVU94saEwb0jGHuMCRj1vwYmznYwIEPq2vSd7TMD3aSMRT0jmJFa6f8vi+PO/kemvQ==
X-Received: by 2002:ac8:7c46:: with SMTP id o6mr4946928qtv.587.1642603763909;
        Wed, 19 Jan 2022 06:49:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id z11sm4717707qta.1.2022.01.19.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:49:22 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nACH2-001K1X-E7; Wed, 19 Jan 2022 10:49:20 -0400
Date:   Wed, 19 Jan 2022 10:49:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Praveen Kannoju <praveen.kannoju@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>
Subject: Re: [PATCH RFC] rds: ib: Reduce the contention caused by the
 asynchronous workers to flush the mr pool
Message-ID: <20220119144920.GL8034@ziepe.ca>
References: <1642517238-9912-1-git-send-email-praveen.kannoju@oracle.com>
 <53D98F26-FC52-4F3E-9700-ED0312756785@oracle.com>
 <20220118191754.GG8034@ziepe.ca>
 <CEFD48B4-3360-4040-B41A-49B8046D28E8@oracle.com>
 <Yee2tMJBd4kC8axv@unreal>
 <PH0PR10MB5515E99CA5DF423BDEBB038E8C599@PH0PR10MB5515.namprd10.prod.outlook.com>
 <20220119130450.GJ8034@ziepe.ca>
 <PH0PR10MB551565CBAD2FF5CC0D3C69C48C599@PH0PR10MB5515.namprd10.prod.outlook.com>
 <20220119131728.GK8034@ziepe.ca>
 <PH0PR10MB5515039926FA5F66537A6EBB8C599@PH0PR10MB5515.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR10MB5515039926FA5F66537A6EBB8C599@PH0PR10MB5515.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 02:08:48PM +0000, Praveen Kannoju wrote:
> From: Jason Gunthorpe [mailto:jgg@ziepe.ca] 
> Sent: 19 January 2022 06:47 PM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Santosh Shilimkar <santosh.shilimkar@oracle.com>; David S . Miller <davem@davemloft.net>; kuba@kernel.org; netdev@vger.kernel.org; linux-rdma@vger.kernel.org; rds-devel@oss.oracle.com; linux-kernel@vger.kernel.org; Rama Nichanamatlu <rama.nichanamatlu@oracle.com>; Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>
> Subject: Re: [PATCH RFC] rds: ib: Reduce the contention caused by the asynchronous workers to flush the mr pool
> 
> On Wed, Jan 19, 2022 at 01:12:29PM +0000, Praveen Kannoju wrote:
> 
> > Yes, we are using the barriers. I was justifying the usage of
> > smp_rmb() and smp_wmb() over smp_load_acquire() and
> > smp_store_release() in the patch.
> 
> You failed to justify it.
> 
> Jason
> 
> Apologies, if my earlier point is not clear, Jason.
> Let me reframe:
> 
> 1. The introduced bool variable "flush_ongoing", is being accessed only in the function "rds_ib_free_mr" while spawning asynchronous workers.
> 
> 2. The ordering guaranteed by smp_rmb() and smp_wmb() would be
> sufficient for such simple usage and hence we did not use
> smp_load_acquire() and smp_store_release().

Again you haven't defined why these barriers are any differnet from
acquire/release or even *what they are doing*

Jason
