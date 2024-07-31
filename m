Return-Path: <linux-rdma+bounces-4135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD45942FE6
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 15:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811641C22646
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257501B29AA;
	Wed, 31 Jul 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iE/cdtcb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D21B1505
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431752; cv=none; b=CU7JmN5UNgTQrvzPSEgQoBzrQD/p+LyZ0E9M1nubq1yIhk039ZLYaAI3NOiP5QRLdUY7pmXyGWD8aYQNNaCd5MLBpvo/Z873AaZeLTvW03Qz1uU5N4fnStg00U08IzWucvMeeZ2N737Ea4zEMRtpUn0qoygLJ2/u1b7AMMNjGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431752; c=relaxed/simple;
	bh=0qkwQ0MmMQBMbBAsVU4qO+QelNoT7Eax5wkEMJX06Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMmcTHmavznTMjKbgDI9xKtd4QZiDqpjY6b34GJ8J+bOPMFJRjf67C6b7cAKWXkYXSupUPQZBcIzgrp6nJyzFCncSNEJ5xRcIncOsSa0avccuc9xea2ggUj6Ne7lOpdmS+k4ZlD78XkQOLC6kpu2iO9LfHK05JHV96SWYCfQxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=iE/cdtcb; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5bcccb372so213225eaf.3
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2024 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722431750; x=1723036550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ean7sSS19FfLz1vX4VUsoj/SGZS7nDauOxzT51mpNiw=;
        b=iE/cdtcbx5TpAW8uFWQybJq0+Ye18m6DIdZ8FASb5OvxoUUx382OJ6sRmHy3Og28tV
         1OmkL667l8C5T4pPkMvc8POKbzgUZCuA4w4TcJmZL9jtGdrnp1LEIiXAANSx13WhvAzZ
         HJLheAQXc351cCxAnRedIZTKp83O9vCXzYAo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431750; x=1723036550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ean7sSS19FfLz1vX4VUsoj/SGZS7nDauOxzT51mpNiw=;
        b=F+em9XkvJw6BlakCZ5Rx5rzx8unkxeq8Yc15LmF3twjW1xVwaOqSG2U70ne6DKpaEl
         jKigWgBX3GWzhLHc/J3Js+8mSFyT2+Rmguu95RPASyfTh2yzPLvpmpA33xwLQ7aBD93j
         wfny3dXMpop6U0kYqO7b078pn3ZcdGEvGfVECNcz1DeYibnx6J2oqI+f6ThQBF9tI9Di
         KcrKsi0Va/5E/m7X1Mh4e+II2rl+Fe90NYgb2aNtx2535C2YBGZOsMAU+xrLL023NGWW
         6/3c0TZ9bRxTDcend9PdvttJWdEAUjbXr/jKkgEvXsaPl/cfa3J7498meHsRjne83eDj
         Yk5g==
X-Forwarded-Encrypted: i=1; AJvYcCWrBSNxaZbENoh++ep8ngHRluySMP30qCjb031wQdnCZ/1FkJoxNIqqSkrPsyHUubALlsQ7BPOFbGnH8uAxDl6cCwDMsfnYW8e3zQ==
X-Gm-Message-State: AOJu0YyHyTFr7SRpVBw06mSDl7uFPZVepJ5y1oro6IATq3Bro9SpwjyJ
	+79JhfzvopjbF8ZvMCF5SuaMhKAoNzBGxY9Yy2tiOlqREUdAFP4JUFo6Z9z7h1Vn4YRVapinsCT
	7FnI+v8HGIFVNx9nvsiuKbDPnQ4cuKpOj2i7VRw==
X-Google-Smtp-Source: AGHT+IFRXAg1VLup8Q5b6YTsFY3klhFNVf83mG/k3C+eDgnwe1Nu09nxYmzuT2rekf8aCOwmOO+FFi5mCTeogw6pn3w=
X-Received: by 2002:a05:6871:9c01:b0:260:f1c4:2fdb with SMTP id
 586e51a60fabf-264c4479917mr11725728fac.8.1722431750651; Wed, 31 Jul 2024
 06:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721192530.GD23783@pendragon.ideasonboard.com>
 <CAPybu_2tUmYtNiSExNGpsxcF=7EO+ZHR8eGammBsg8iFh3B3wg@mail.gmail.com>
 <20240722111834.GC13497@pendragon.ideasonboard.com> <CAPybu_1SiMmegv=4dys+1tzV6=PumKxfB5p12ST4zasCjwzS9g@mail.gmail.com>
 <20240725200142.GF14252@pendragon.ideasonboard.com> <CAPybu_1hZfAqp2uFttgYgRxm_tYzJJr-U3aoD1WKCWQsHThSLw@mail.gmail.com>
 <20240726105936.GC28621@pendragon.ideasonboard.com> <CAPybu_1y7K940ndLZmy+QdfkJ_D9=F9nTPpp=-j9HYpg4AuqqA@mail.gmail.com>
 <20240728171800.GJ30973@pendragon.ideasonboard.com> <CAPybu_3M9GYNrDiqH1pXEvgzz4Wz_a672MCkNGoiLy9+e67WQw@mail.gmail.com>
 <Zqol_N8qkMI--n-S@valkosipuli.retiisi.eu>
In-Reply-To: <Zqol_N8qkMI--n-S@valkosipuli.retiisi.eu>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 31 Jul 2024 15:15:39 +0200
Message-ID: <CAKMK7uGx=VjHCo90htuTE6Oi0b8rt_0NrPsfbZwFKA304m7BdA@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dan Williams <dan.j.williams@intel.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 13:55, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> This is also very different from GPUs or accel devices that are built to be
> user-programmable. If I'd compare ISPs to different devices, then the
> closest match would probably be video codecs -- which also use V4L2.

Really just aside, but I figured I should correct this. DRM supports
plenty of video codecs. They're all tied to gpus, but the real reason
really is that the hw has decent command submission support so that
running the entire codec in userspace except the basic memory and
batch execution and synchronization handling in the kernel is a
feasible design. And actually good, because your kernel wont ever blow
up trying to parse complex media formats because it just doesn't.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

