Return-Path: <linux-rdma+bounces-1323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF01875745
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 20:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29AD1F24043
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DED137C54;
	Thu,  7 Mar 2024 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H35LTl9r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78971136663
	for <linux-rdma@vger.kernel.org>; Thu,  7 Mar 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839948; cv=none; b=gks0OSMoy1BrRECcWTksnp6kiljMjDMP3SCMcXwx25NDMa7BctZkKHBcWL/r3x2pihUs/sWfPcy4nhC9iHI3mh2aW+LXGEmh8yd9+qQzg7ZPTNgcwfRQj+Ueu1PBN1s5Wwl49PsCagZfgS76Lmr57IP3YUmq5ccaH5odsxt74ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839948; c=relaxed/simple;
	bh=7GcxakZLq2oKSdXj+ofXzEBmRC7bzIxUkfqgxs8FG00=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EcHs/qPJ+2GL8geBCrseoJDc6EIcrKwjbHuNHZLZpiVW/9HBPP/ahznl9xG67lK6cCzWblBvIj8ix3/WVTIxNeEIGRRydKHoM3/aTxokdEfB4xMQ+c2pV4A7wIvHV6FRK1yj+h7nPbD6/fEAa9heJHkocp8aUGkMjHIRDpHNyfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H35LTl9r; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1032195a12.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 Mar 2024 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709839946; x=1710444746; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9qoSXzYZPN9ruMFhEGa01LS4BMnI7rAvWb4nFTzmXc=;
        b=H35LTl9rrbmwdPzJ9BEr5gsW4yRvPb0B1ueFvVOAbbFCM1oOUGvMzXBIBjTaInzwOZ
         p1FgntUUc1QUgw45r9wD1UyX3tBagKyGJDc7/EqCUuAgNBWsLfkyFwlJiabT7weDLDb+
         NjOG3U5WmJKpZcGN2Mft/gDtzpUx7IA18poQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709839946; x=1710444746;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9qoSXzYZPN9ruMFhEGa01LS4BMnI7rAvWb4nFTzmXc=;
        b=QGT+Nl2L3t1c1yX1i/rswHsUozbOCsNOgD6tIEK9vgyaAevhVXRPA09vptNw3stI6r
         krdiRJXqspaubHmZZ0/IsaFVZkUZc3Mb9+gjjHleyJVFGX8fSE+8pv2h+xLbw3YjaQyt
         g+vlNQuvhiPfi90m9xVgtcFVEAMWfBfhWS0A4T1l89Mgi/W5EJWoOAJi6wZw3AVuOxoJ
         6WFnoxqDbFj4FgOak1K10uwTno6kSzTXm/aQ/hsl8bCCfk6IIwfwCSf6YJx3RbKoIJtb
         Iv6zmgQyiuS+XAv9VUbDSqOCuko15YVztrG+swEOTV008qGpYyBRqi1zDwSjVpe0iG/R
         Orrg==
X-Gm-Message-State: AOJu0YwEx+Wnu3OYNfPs6XgVIS40M/CuxEYiQ5VomGDCQUh3PqJqSYzt
	PmykME9F6OJ517jva5olBd65/ahNucmn4zNLsnSXNqvLu3aLCfXP0gaWm9UE1w==
X-Google-Smtp-Source: AGHT+IGOLBi4Qz9QnVx9qVdy304kZfGTtm1ed+Ruod8ne2tyM8cAlmd20ukwkMkoXTBqPPYmDqQq1w==
X-Received: by 2002:a17:90b:24d:b0:29b:9c8f:5ea2 with SMTP id fz13-20020a17090b024d00b0029b9c8f5ea2mr1766760pjb.40.1709839945732;
        Thu, 07 Mar 2024 11:32:25 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090adb9800b0029a849e7268sm1908119pjv.28.2024.03.07.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:32:25 -0800 (PST)
From: coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date: Thu, 7 Mar 2024 11:32:24 -0800
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Allison Henderson <allison.henderson@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: __rds_rdma_map(): Null pointer dereferences
Message-ID: <202403071132.37BBF46E@keescook>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20240307 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Mar 6 11:58:42 2024 +0000
    c055fc00c07b ("net/rds: fix WARNING in rds_conn_connect_if_down")

Coverity reported the following:

*** CID 1584247:  Null pointer dereferences  (FORWARD_NULL)
net/rds/rdma.c:306 in __rds_rdma_map()
300     			unpin_user_pages(pages, nr_pages);
301     			kfree(sg);
302     		}
303     		ret = PTR_ERR(trans_private);
304     		/* Trigger connection so that its ready for the next retry */
305     		if (ret == -ENODEV)
vvv     CID 1584247:  Null pointer dereferences  (FORWARD_NULL)
vvv     Dereferencing null pointer "cp".
306     			rds_conn_connect_if_down(cp->cp_conn);
307     		goto out;
308     	}
309
310     	mr->r_trans_private = trans_private;
311

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1584247 ("Null pointer dereferences")
Fixes: c055fc00c07b ("net/rds: fix WARNING in rds_conn_connect_if_down")

Thanks for your attention!

-- 
Coverity-bot

