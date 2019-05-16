Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85520D6B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfEPQvv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 12:51:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42602 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfEPQvu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 May 2019 12:51:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so4691097qta.9
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YUOmhRu6B31fENCY1L4Ku2Nfim/TsoO7oovJxf9dV4U=;
        b=J+mze5qBeRkKoT797fsfcxyX58R84ClJnPS+h6zENL3ckFop75cc9XuXD+RMFMK/f8
         sAOuKw+INA/XrsrVD5j3vRVZZvk1EOndbI09/+QxGrOSLrxwWahqji4Lxn5+xDO5RVPE
         2nriMbvxANZt5HkKn4ntxM4ddAdmrj/By4QGaicCnLe97keOOUfHTWmQiSrrkdnLO3HG
         exyB+zuUCHyAd2ZLIpHDprakziwKxSnVo9/0/qT+Fyld78Xy7zOt21cA5B5i6gqfGVW+
         pBBFf2dzwolVgaCrzLn30CJVLKUOOwuNxFATMS9bw0cbRd/z5LHv2tFB8YzTHB8stYCz
         oLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YUOmhRu6B31fENCY1L4Ku2Nfim/TsoO7oovJxf9dV4U=;
        b=oN5DQq8Ia5k6z7ZC6iqfmCTsTo2whnUhaeROLFcQmLncFjA/lNQktDX78/1NOzVhf6
         2825Ey1Xxo8GqlfUQFPDc6sxRvXijpQn6LsLuxXIa4SLg7HQwfK9pq/kSTM+qv7YCFJl
         3+bzHhxiKeSsBCV7R98T1wejoTtzruCMkQ9dp8H34I+3RiNfClRivyBpJ8kxtSUc6wij
         a4soutXBuca6ozheTZBXg938W2+PF8qWq+O3H5omMyX9N/uRQS10MwTms3u+saNNnOwM
         B0VyFgMo1UvLaJFdGTreoQE4LdE6AUv02fJ5TwC1fa6urgYWZJhwkxJM52yn36N2k2Qh
         DxnQ==
X-Gm-Message-State: APjAAAXNfL7E/cEtGTznqiObBTjDIEQtUhc+BdEOoh1IeljAW/PRX5GF
        xCWZmz+oal4H80826njobuEeZQ==
X-Google-Smtp-Source: APXvYqz2wGqIEEs+FgPT3IzjATjmKne5oCcYwAN9ozH0cfP+D8seD2LFt5GMcU2SD0OIYf1pf+8WJQ==
X-Received: by 2002:ac8:3390:: with SMTP id c16mr43217440qtb.315.1558025509885;
        Thu, 16 May 2019 09:51:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t58sm3475424qtj.4.2019.05.16.09.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:51:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hRJbh-0006vf-4E; Thu, 16 May 2019 13:51:49 -0300
Date:   Thu, 16 May 2019 13:51:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core 06/20] build: Support rst as a man page option
Message-ID: <20190516165149.GG22587@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
 <20190514234936.5175-7-jgg@ziepe.ca>
 <20190516164734.GC6026@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516164734.GC6026@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 07:47:34PM +0300, Leon Romanovsky wrote:
> On Tue, May 14, 2019 at 08:49:22PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > infiniband-diags uses rst as a man page preprocessor, so add it along side
> > pandoc in the build system.
> 
> Why don't we convert RST to MD prior to integrating infiniband-diags
> into rdma-core, instead of introducing extra dependency and complexity?

The ibdiags stuff uses RST's #include feature extensively and
unwinding all of that is simply too hard. Maybe someday we can do it.

Jason
