Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33F81ED65A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgFCSsL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCSsK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 14:48:10 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816CCC08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 11:48:10 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y9so1650918qvs.4
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sJwtp1Vzpu4YpA4iwlq49lhOfHSduYqN9iSTEyQpxIw=;
        b=GuIn6q5CN68nZySIsDfY3+H0DZesrDIX5ZAHIVcsuI5UFx50mzoap98WmHNfyL76LY
         r7EI3XjvdgSXNfzxQDSFB/dkY95lwct+9WImUoHavkX8ick6eqcfJ29v5JFF49axumaS
         1tVpFZF/WnTiRy5LpKPRhkSUt8yvmmtbcDWQgwJD+6cYK9QSnaH15FE6ANUw74mAFgP0
         TycBtM6UohSCGibj2Qz9g2fwuZpU+rRFHWp7r4vx2CILp+3c3V/RIqebMBSwuvhP/M72
         vemeSU1lbvMVG2tQXSW19UctVEVtzjuDQRXuWUFPpYubUWGSTetoQMDm+z1Iv1LRgQiz
         pjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJwtp1Vzpu4YpA4iwlq49lhOfHSduYqN9iSTEyQpxIw=;
        b=E7Fh6JXQSDchpNpJwFHDqPMyDraJ7xMiQxlunWu4VkjUxrtG2fjQnHJFXVDAdKCFnW
         go58pB1/ZA36I2PWUUNOzJetjkC5uo8JyP9cMvaTJs6+T8bjbvx0xrR2v+VHfOiG2bcL
         81m//TCC9jMrRyyCrSXF79cbPqM2Jbt3IGYjpsDlHLxbqrpLZ6xxUe+1U80R9WdZBa3u
         uomKKmfXoKnL6NygAwbIBfWzpUTJNvMbH+ij4PbEYBbplJHltGHpbrD3bu0V9Jt5NReq
         hWn/LkNg13nDxsGnIZLvuftSJ2FAde7jiD4OgKpPxGB6OtzM5ThkHbY3sbUoa4R4yxpq
         z4mQ==
X-Gm-Message-State: AOAM530ITlxTFToCackVRV0fchz7d2tpBO6NtyBMhC3q13IuIKY/jnsW
        g41dIk3D+vaGBTj1xCYCs/K0hrXO+3k=
X-Google-Smtp-Source: ABdhPJwxRDSWup6O+rHgLejMFSW6cA23so06ca0kCW6k6Ft9MZlTVL54H4RRMlqB7GHjt1UCP9Bqrw==
X-Received: by 2002:a0c:9a08:: with SMTP id p8mr1275146qvd.54.1591210089722;
        Wed, 03 Jun 2020 11:48:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g13sm1986217qki.95.2020.06.03.11.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 11:48:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgYQq-000t3A-JG; Wed, 03 Jun 2020 15:48:08 -0300
Date:   Wed, 3 Jun 2020 15:48:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 0/3] mlx5 ECE fixes DC ECE code
Message-ID: <20200603184808.GA211562@ziepe.ca>
References: <20200602125548.172654-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602125548.172654-1-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 02, 2020 at 03:55:45PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This are three patches which I would ask to consider for current PR
> to Linus.
> 
> First two patches are fixing corner cases that are not possible
> in the real life and the third patch is needed to ensure that API
> toward user space is feature complete and won't need any extra
> ucontext flags.
> 
> The code of third patch was already presented in v0 and v1,
> but was dropped later.
> 
> Leon Romanovsky (3):
>   RDMA/mlx5: Return an error if copy_to_user fails
>   RDMA/mlx5: Don't rely on FW to set zeros in ECE response
>   RDMA/mlx5: Return ECE DC support

Applied to for-next, thanks

Jason
