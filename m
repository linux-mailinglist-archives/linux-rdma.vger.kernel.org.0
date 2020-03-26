Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989491947E7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 20:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCZTvi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 15:51:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38067 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgCZTvi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Mar 2020 15:51:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so8249393qke.5
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2020 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+BXCPM17Kpjvr3aLKXeH8lEJZOFfZdxA/s9ViHwP+A=;
        b=j2KiKjuDlHHxKba/qcYNmPCo5uaygamaExf6RRMn7kGYLSi8dT/JMtGHnjDRFjmwwl
         EkiqZyXge881xB6TbnmQZIKuQrdYHGNR3xf+Sq43f1Ix4o6X/OR/HKVbcR9BccqFFwJL
         J7p+qnOa7RLkaztkuhh4zVqAXVBCxrdxZwIR68/dMhytMRjKwJhc1iRi42GADWUgErEu
         r9Dmnsi5IV6ZoBi5OpGXQvwZ5xEa2xzxIKRo0NfaFppu4g39aVOcFIBkH8F1FcbX5uhL
         TQdVPMIxBc61sG9SSJZA3x7uVFLihtlTEWtt+tVZvjvkPkezfGWTSep7BxTwKko5vMz3
         cCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+BXCPM17Kpjvr3aLKXeH8lEJZOFfZdxA/s9ViHwP+A=;
        b=UXOEcfa7MB1EHzk3yO+RQ+cvvcMdcOX8mdM07SXbIK2GGzS02jdsg/wfEd52wkE2Jg
         BG/QR5+jgs8YWcIFSybZxEXQQwD9RnVO6CQrFVQIlL/+Suck/zKQJ2Vtwhc/o0VLpHOj
         m5Ya6ZpQR0JmsRjh3Qf/xyiOuatQyQboDzKh1/ew/tXZRyQraDc+kO22POK6Xnvx0fEI
         oau0RbRr4ED++Qik7Cc7nVK8NKvy3og3p4H/5YbzsasOiKbDoM7/C2MCHUBNk60AVPP7
         So8ZxiW29Y0XMwemuWluEjZhmPjCgn/IeUjEGut55ikE4lWA+uFnro0SIv5zWSutFdzH
         WLBQ==
X-Gm-Message-State: ANhLgQ0ENXlDIqujUS8WdokmWNzHpFpT457YBoiS1zLRz4+fDdhewhK5
        j/D2MG/M72ceMCyzU/K+kAaAUg==
X-Google-Smtp-Source: ADFU+vvZNlscOPEHfRzHVh7pXN/FXo99Z081MyWtmk6LA2IryO3Ej0DWubKIW/OkYCxa71hWthNnXw==
X-Received: by 2002:a37:8cc1:: with SMTP id o184mr9911486qkd.187.1585252297023;
        Thu, 26 Mar 2020 12:51:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a200sm2122631qkc.13.2020.03.26.12.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 12:51:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHYXP-00077C-53; Thu, 26 Mar 2020 16:51:35 -0300
Date:   Thu, 26 Mar 2020 16:51:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next 04/10] RDMA/hns: Optimize
 hns_roce_alloc_vf_resource()
Message-ID: <20200326195135.GA27277@ziepe.ca>
References: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
 <1584674622-52773-5-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584674622-52773-5-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 20, 2020 at 11:23:36AM +0800, Weihang Li wrote:

> @@ -2028,6 +2002,13 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
>  	if (ret)
>  		set_default_caps(hr_dev);
>  
> +	ret = hns_roce_alloc_vf_resource(hr_dev);
> +	if (ret) {
> +		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
> +			ret);
> +		return ret;
> +	}

It is unfortunate these have to remain as dev_err()

I've thought about setting the name during ib_alloc_dev, which would
avoid this, what do you think?

Jason
