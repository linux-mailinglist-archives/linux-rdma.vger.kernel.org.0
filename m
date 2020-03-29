Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9749196DD2
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgC2OJg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 10:09:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34423 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgC2OJg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Mar 2020 10:09:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id 10so12879089qtp.1
        for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2020 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+6Rly/eq3CvlCxoZZD4cItQFM+75stmDLJ61LAi4cM=;
        b=diKqiAo/UiP0sb3oKezvZ48o9Tq2bgPoiNzYZY/giSxyb62EC1VuudUfFS5qlcqtNE
         4v54AEF5Cc8G/eQaa9eCn7w0iJ10pPN+AaroLgxGzwsFSlwdAYMj/MTwPjAPytbW5GMD
         NFbTcKjS+C6OVz8DkLoH6ypW86fKu+r/fpSTqJYaEjsao+Xa+dwslXMrG9Vn1vt1E56s
         g+w27aT6WRTDxa3BylzwAZWHqCXj1qs4CDsJ1l06id1NeXKfT+KYLq/rqHfWgl7Gcm1h
         B1Jfkxvn3lZV/zt9Y0An7P49cdEy44cbWKXo1jX6VpMxlLjv+F+r8sAB0HB8lb+5G0VO
         hUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+6Rly/eq3CvlCxoZZD4cItQFM+75stmDLJ61LAi4cM=;
        b=S153V67ErA+nndkdOoYNVxeNQoakX52kHnPCOChL8XnE2sOwvWTd165TH6oBEC+0pS
         /KJQXLx5eXB7KjPvAAKW886wbXWgbRYyIZrjvdgPaW63Zx3ExHhnp8wSpOS8uiDvs9xV
         rBB4i5rJ/UK2xkmlSMdkSVc2FMkQutJqqxLFF7KOUOK0P0qhwR8Bsbof1KDSp6yguWN5
         o9NZ/nefKfq4ph6ORdY/9Kb2JBD0jq5r9DwK5yG4ZWpfGYrU1oKJeuYSp7vDSz3ehKEX
         O1egMT3liORj6huFHV7eJhmXPYSxM3o4WK1M10/BaDnbtnVGVPSoQTTsnc0QO6+Utjmh
         n7OA==
X-Gm-Message-State: ANhLgQ3LZIDI66atJ6ypkEcFcYFzigDtPbueuL11NJE7MAUHdEAWOown
        GXNQAy9auhOG9nZ0Omt+BEvz9Q==
X-Google-Smtp-Source: ADFU+vvklDBE2iqnhxWbAvNwTweUI6ldm4oRv/L5HSeXpLcr34H0q6LDLeNjD8FAS+uSUoquRdvT5A==
X-Received: by 2002:ac8:38cc:: with SMTP id g12mr7933194qtc.186.1585490975307;
        Sun, 29 Mar 2020 07:09:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i186sm8279065qke.5.2020.03.29.07.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 07:09:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIYd4-0007A6-4D; Sun, 29 Mar 2020 11:09:34 -0300
Date:   Sun, 29 Mar 2020 11:09:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Update some configurations
 related to hardware
Message-ID: <20200329140934.GA27488@ziepe.ca>
References: <1585194018-4381-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585194018-4381-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 26, 2020 at 11:40:15AM +0800, Weihang Li wrote:
> These configurations in hns drivers should be updated to adapt capability
> of hardware or improve performance.
> 
> Jihua Tao (1):
>   RDMA/hns: Reduce PFC frames in congestion scenarios
> 
> Lang Cheng (2):
>   RDMA/hns: Reduce the maximum number of extend SGE per WQE
>   RDMA/hns: Modify the mask of QP number for CQE of hip08

Applied to for-next

Thanks,
Jason
