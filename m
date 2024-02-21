Return-Path: <linux-rdma+bounces-1087-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217785D849
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 13:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61491F2365C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53B6931B;
	Wed, 21 Feb 2024 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGYe0QT9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7E523D
	for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519907; cv=none; b=ZTa0vsEza65bqnarvMlC9AmKHz32sHh3F7nf6XR8OgNcf1Zm1qi7nd+k1y8GovKyM4LPI0+BLkDVi4t84U2nQwScrTsIDQr8BE7q4z3wUo+2E9vNcdTkM+p2FeDnFTsunSZwOcazxJyR5eTCOSnGu+O2qaGv3EWuRVJRysB1O0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519907; c=relaxed/simple;
	bh=7SxIRrDMrbOx0Wa3HujKQo9aJFEi5x+mabSWiYpI/M8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=AFDUb1rLO9ZuioDunNWGz9/eTn+bL1y/NTs1tD3Z8FwzJIZLfcJpQZ5sCdS8dZDtXmJYTzxXj18McTavO/f7cAtfy9yexjkh4IhONo2uSx7wt7uyHBB13/baVhWbIgXvFl/V7LpBu5PpUCrckU/xugVqFvRIXi9PKWf2xfgrJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGYe0QT9; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20503dc09adso4128704fac.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 04:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708519905; x=1709124705; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fSbhPuMI/xlqHdCkwYZiOSYqe+jWhtt+6Sq+QccYH8=;
        b=CGYe0QT9pvBtALJ606pgCnpKfBAXFPRUbdC2NZP9eDEZ/ZA5i85kSM5RDUstZg60+M
         AGpMJJG9GmzFTWZq6FR28bdPmvF9JB+2Yo2sfufuNhmknpIMG81wsmC2Ykzo59nLRsPZ
         qfGVDDaBgdGUKdJUU/H+sbw9IIQBEBeSoh+RIoOIJJ6tVWPoJvR/SCW0paKKKLHPZ7k0
         SgtYqXJNtcmj/ug+2uGcm+aR1NBGwY0QAloNz32Wlz83t1XfrxTk8iSVj+6dUNd/iS/B
         Q0Nrk6XDznddGsnHEHE8NxGeHaCXvnt9vFoI06c4bU/yhDwMhot8uG4Scs5Koiqbn1Z9
         WI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519905; x=1709124705;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fSbhPuMI/xlqHdCkwYZiOSYqe+jWhtt+6Sq+QccYH8=;
        b=VNPFcBSpTn2rxzVxzqGV+eV4fX4/Z9QklZgQhxDARJ4aiYGNf25Rz9lYtwZ80sEFfx
         bFVVU8JxnqiLWgxHKV2/8w3JOYO22UNHa54x+4FP93wwWUgT5HdYJ5tf/Ti5vJMQbooH
         Ze5xtP9GlOkHw2y4WpztawBeBqCBSx8m9qVOztXEl1GAInwmGh85t7WCS/fj53/oF9ok
         2G/uloTRnzlE9J1vOg602P3Vlf+QACw8En9oKfMt8GOYqAMMrz8nG73qnZV8GJy6aP4a
         cvXGRofMi1jqpxvmNQzKrLsQxiq3VcGMc66+JwrVov8xUBZmOMd2UUz/lIXpOJ4vGeSn
         6jeg==
X-Forwarded-Encrypted: i=1; AJvYcCWmdMWtz8vqzQQ0RUE5s2NwE/Mv7qlXuCNZ81CTX186sEYcrCUbLWLXDYpVNt5vNYGmwTo/+nKLRc2nHXstjRs7ZrnKKvvnmUNZkQ==
X-Gm-Message-State: AOJu0YxdLpJnabK3yHiRA0ZugtJLGcswU/1/HuefWUEd1jrpcUXjBB7O
	8JuM5Bp19hwf0YC/M7seq7VMqm8VrMemg4UNssQSiBsgBxuSflGy
X-Google-Smtp-Source: AGHT+IEdJNP33/ofg9espFLeEgubsB6zR5C4k4O/1N+C/Dw+QqVa3DAsE7+xcm1/KVMWr5oXslBW6A==
X-Received: by 2002:a05:6870:8192:b0:21e:6672:a46f with SMTP id k18-20020a056870819200b0021e6672a46fmr16976648oae.29.1708519904879;
        Wed, 21 Feb 2024 04:51:44 -0800 (PST)
Received: from smtpclient.apple ([2601:6c1:500:2c60:480c:13c7:27d2:6b89])
        by smtp.gmail.com with ESMTPSA id sf12-20020a056871230c00b0021e924c017esm2052631oab.58.2024.02.21.04.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 04:51:44 -0800 (PST)
From: Kevan Rehm <kevanrehm@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-Id: <F15A1D93-2FCC-4697-A780-38D9F2383EAA@gmail.com>
Date: Wed, 21 Feb 2024 07:51:31 -0500
Cc: Mark Zhang <markzhang@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>,
 Kevan Rehm <kevanrehm@gmail.com>,
 "chien.tin.tung@intel.com" <chien.tin.tung@intel.com>,
 Kevan Rehm <kevan.rehm@hpe.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

I posted PR #1431 for this.   I tested with IBV_FORK_SAFE and =
RDMA_FORK_SAFE set and unset.  Also with UCX_IB_FORK_INIT unset, set to =
no, and set to yes.   All combos work correctly without segfault.=

