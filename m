Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF8493AED
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 14:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354700AbiASNRd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 08:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiASNRc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 08:17:32 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70223C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 05:17:32 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v7so2189788qtw.13
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 05:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uLFGZqyJySmbyBQ4sjesJ1t4m/84/5hhnfPmzo+DBaE=;
        b=HQt2tqp6zGYhfblEra0zM0+FR6k6EeUJiZDEUZWXH2TZNLdPWXYj3HNzafScmi92E0
         6ZwiRGFw8bnL8Fu6BT7PEjlwuEMVONf2ofHY/L5Zm3cdachcT8xjhh4icQvmmpFmQXkO
         Alu2+h+b2rBAnr1viwICoF32r6L5GU4VjQtMYktCOVD5Bp8Pud77VHQvOJvANaKfk3Ej
         /f0v9Q3eGOB1k3u+jaPh+UYk8XSzOZt08O9+1HIRfDAngLpd1S1IWB9zV/4jhRmeYK0C
         /t7DktEQ0t/YYeDUjdVlErCHCMRg6ToT8TpX9gu4KqI8twNLG6WN2JfDFVR6iS1DUSuK
         C6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uLFGZqyJySmbyBQ4sjesJ1t4m/84/5hhnfPmzo+DBaE=;
        b=eDwfMDrN4n7MsJTLKG56P0pxnbRz3DGjWXbssYEUhuwKmPI1iU5Eea2/uoyq21loN+
         S+R7U0LBkZIYD0Vc4F1LQPoMGrNoGAzgBx4jZ27UeT6xpQ+buTWri4nkIOlHghPBQ4DJ
         s29IVaU/bYMxIgrlLvCCjfDbq//8+3o+A603KzGBNm6r2rHnOQplVQzD915L7at9BQen
         2MTl/XjgPFz1bjSftu0buJyJF7HTwoqHbvsyW060KhTuXJoPu3IgupuEGZvgfd/bfYZc
         tIiee6COcqgAk58ZhS7D6Byx97L8/uzFWnB27JYo4HMYbYexTedYFXZ3ROIMSci5K41l
         v2ig==
X-Gm-Message-State: AOAM530R/QOtJXXUxRLHOunQVAX5MwlHQQ1YL85e5KUbtf0wVrpoJ0vg
        B/q8Y668NkDgOYRDy2nIObSlvQ==
X-Google-Smtp-Source: ABdhPJw0y5MaVc+dgVB8CBigVZFZt3DgJA+Wkso3kEA+8IErd9EFFOFWXCTUIRdqKkU80gp5ZpjBBQ==
X-Received: by 2002:ac8:5cd4:: with SMTP id s20mr18611650qta.299.1642598250063;
        Wed, 19 Jan 2022 05:17:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i14sm242296qko.18.2022.01.19.05.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:17:29 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nAAq8-001IVe-UU; Wed, 19 Jan 2022 09:17:28 -0400
Date:   Wed, 19 Jan 2022 09:17:28 -0400
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
Message-ID: <20220119131728.GK8034@ziepe.ca>
References: <1642517238-9912-1-git-send-email-praveen.kannoju@oracle.com>
 <53D98F26-FC52-4F3E-9700-ED0312756785@oracle.com>
 <20220118191754.GG8034@ziepe.ca>
 <CEFD48B4-3360-4040-B41A-49B8046D28E8@oracle.com>
 <Yee2tMJBd4kC8axv@unreal>
 <PH0PR10MB5515E99CA5DF423BDEBB038E8C599@PH0PR10MB5515.namprd10.prod.outlook.com>
 <20220119130450.GJ8034@ziepe.ca>
 <PH0PR10MB551565CBAD2FF5CC0D3C69C48C599@PH0PR10MB5515.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR10MB551565CBAD2FF5CC0D3C69C48C599@PH0PR10MB5515.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 01:12:29PM +0000, Praveen Kannoju wrote:

> Yes, we are using the barriers. I was justifying the usage of
> smp_rmb() and smp_wmb() over smp_load_acquire() and
> smp_store_release() in the patch.

You failed to justify it.

Jason

