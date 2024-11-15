Return-Path: <linux-rdma+bounces-5993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1009CD609
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 04:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134671F2243C
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 03:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DC1632F1;
	Fri, 15 Nov 2024 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G04qIdfD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCAC15EFA1;
	Fri, 15 Nov 2024 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643037; cv=none; b=aeyuam2w61Sc/uI9HMxVhK0mP7/tCQ6exF0VFDmzz9afKm3pKFPXY/nCX58/XEBHsDAw8AQHtoJ+NAtpzZpiOVmYVNMoMCZlqDqPFZG87ZG2ePQ2DkVKTbqLzjW1sdM+UtNJY2evPYV/BpQh9GB0RszOkbiO2jIC+udxBIWbrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643037; c=relaxed/simple;
	bh=RxR68/lpc6QiHrHq9Ith4d9xg6HEqBllLeW/VlRCX7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlYHPpZLjLs31B9FxAIvgv9OO2cWqz8cBHzgd6qgz5BWpK3Ciuot7rBmOwRPkbJY0zHzzADVf2kvzRNTzR1w8cOTsQVngqMx9a+ud6OyvEge97i9a8vyHge3G3zuenKRWLqOIJj0DW3vWCnuNXpPtYkCRoWqUjvVZjqgMzPMhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G04qIdfD; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d3f52d9598so7257116d6.1;
        Thu, 14 Nov 2024 19:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731643034; x=1732247834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84NDN2Twf/FFmMOiASUdkNKBLbFH7p0mc+7RWEX/RdA=;
        b=G04qIdfDIVy652kiAlHt1yV9wxplvA89y+e2DQuDa5CyN1d37TK0Nc4CWjl7YkELtY
         nLiezZmDwrs+O/Db/CCONWxcRyDTuHlYL+9EtctiA1u+tXbl71/r0vdmgPaVJ1XPbPJO
         SYg6l3fVQv1YI2HkGzHYjuylnpwtF0b9PKBm/wjisUuWSGgd+VjB0Kdk9aHzaJaTCN9W
         OMzn904vdu4dDHrD5Vy6aY5wOtnXiNjDUFj2AmD4DyUR08hn1s+XZA/ih6mvyW/H8VEr
         YPSF+hZe9w5hUXeZCIZ97uI50wY7QddT0XBqUHkg94AhubC9dZi3zYPqkX6Iz7L70rE9
         iJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731643034; x=1732247834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84NDN2Twf/FFmMOiASUdkNKBLbFH7p0mc+7RWEX/RdA=;
        b=ByLJvadzRCW9O6/u98ZHL+pv2MNQXUGzU9M/GcGYYddjLj+m8N6Vkb+IFSvi2eKd6G
         bKxS2mrrdycwuyXp5tIlx3hrv2MEg9Xf/L4BGvdU0IpG4kAFNLRWtayzxFXFtB3PFwBS
         uzlTWqmRXfV1DEiwAtg1V6J1XCVqWr+z3Iw+zQr0UggrZ3NFImGuGQN+gA5M6ghG6Oeo
         HLjsa60mSiVEceXQEozljU8qAzMJbw+QRJ5sbn2fD24EjemcGfF/xpRQ9JxSS40Jdjk5
         g63pzKpcncyCP2eZ91JnLgdtWGv68QBNqEGMqvtCNxlGLCiY5p6/hlFBrRwBArRZ69Dd
         7mJA==
X-Forwarded-Encrypted: i=1; AJvYcCUccb+DZT1N8ZTQPcrvvjq9mg3tNI+lbBj/zQS5VzhlKL1u9xQ6nm9zDD/+GK85Hb853b1ePZGIfrCA@vger.kernel.org, AJvYcCXMGz27WU8rS2ZhkCYH3MeJgo4jjA1hBZZj+HTo3XnnCTTYsn0330fp4WkBP2O7O++ft+5zuLve@vger.kernel.org
X-Gm-Message-State: AOJu0YxGC5ff+R2GYQ8VcbwLbnlzGYZMWHOQHQSMITQAuPAyeM03blwY
	X/R3X7NvJKfjyd4w1QLWeT008V53vZ0/PUS12TpeGyicnLYuQ9USAiRRBNf/2JUAmVyxyN3/cnZ
	+HOl7qCVqT2a4WRWKKwn8defGTw0=
X-Google-Smtp-Source: AGHT+IGckZEir7XgJUV7X3E+Top7BPZZanExiHLmKcY8pGlSgDmQzX/08TWCthLnQQ//6cP13r68fb153djwkVqAGQA=
X-Received: by 2002:a0c:f20a:0:b0:6d3:4992:f585 with SMTP id
 6a1803df08f44-6d3fb9c8b7cmr14571036d6.49.1731643034497; Thu, 14 Nov 2024
 19:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114021711.5691-1-laoar.shao@gmail.com> <20241114182750.0678f9ed@kernel.org>
In-Reply-To: <20241114182750.0678f9ed@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 15 Nov 2024 11:56:38 +0800
Message-ID: <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via rx_fifo_errors
To: Jakub Kicinski <kuba@kernel.org>
Cc: ttoukan.linux@gmail.com, gal@nvidia.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 10:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 14 Nov 2024 10:17:11 +0800 Yafang Shao wrote:
> > - *   Not recommended for use in drivers for high speed interfaces.
>
> I thought I suggested we provide clear guidance on this counter being
> related to processing pipeline being to slow, vs host backpressure.
> Just deleting the line that says "don't use" is not going to cut it :|

Hello Jakub,

After investigating other network drivers, I found that they all
report this metric to rx_missed_errors:

- i40e
  The corresponding ethtool metric is port.rx_discards, which was
mapped to rx_missed_errors in commit 5337d2949733 ("i40e: Add
rx_missed_errors for buffer exhaustion").

- broadcom
  The equivalent metric is rx_total_discard_pkts, reported as
rx_missed_errors in commit c0c050c58d84 ("bnxt_en: New Broadcom
ethernet driver")

Given this, it seems we should align with the standard practice and
report this metric to rx_missed_errors.

Tariq, what are your thoughts?

--
Regards

Yafang

