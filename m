Return-Path: <linux-rdma+bounces-5261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5F79925FA
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3601C222B1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B016FF44;
	Mon,  7 Oct 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZk/gnhn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCFB165F17
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285702; cv=none; b=st/VKJLV2eiJMI7J2IZf2FTGs/kSYsNElym2s+bobMd3AbXwXeg5QXpdC+s1okiRxGPmas9j+/MOFC3+whnjLdYVj2+WXQSeCYXaegvkXmDZ+w5Ryfs3S5yiuf3rSfDds175KczTBtjJ7R1iVJ0X1cN5i6M4fZmBNJygNLi82N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285702; c=relaxed/simple;
	bh=ILC9I8aOsPzl+mFTqNmVV2QwDFzk4jqwlePp55R9I8U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Cv0Z1vXi+xAu5K324tX61WLE98yG0rIzXgMg1lZTOcAz/Ibj59CyogWC4AMgvqPQH6soLDnuR81+sNfVULA3umrgxqSlCLlVGC4mMAOBNZFeEyWOErxIhzrJHh7K6Ypw6Qi8ysNnRrkXMH7wB69ZVWp+nu0LyW0A3XbyEbYdFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZk/gnhn; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e28c9b7a1c9so590738276.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728285700; x=1728890500; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ILC9I8aOsPzl+mFTqNmVV2QwDFzk4jqwlePp55R9I8U=;
        b=ZZk/gnhnzhsAhCaI6wNNzzFj2KxAzm6byRIEMNelq/Ee4M7vSAMdpeyu568Gz3hW26
         9HBdmKGsiAUmpAIfqKWo98qjJGcfOwKTwKvPI7cUyQ9RRjLAVaXZ8XAeb4WQXAeVPCFq
         Abj7qMW9x4qTwJ9PN2db9tUB+9LdcInVYBN7WRel8+wp9KElV82+pLW2EzGxkpbs/bKM
         DOWsGtq/S157AAu2QIu/LNejg1tduwwXas45TSXMMd1oLlNSYgjHErN4EMp6tKulr8YU
         v/MsbcZSPQfti8i24nq8ZgDCKVIVesErfitD5tFMG70/2N9InofB7IlxR7tQpdhMD9Ej
         T7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728285700; x=1728890500;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILC9I8aOsPzl+mFTqNmVV2QwDFzk4jqwlePp55R9I8U=;
        b=HpSjZqtIxvJVILdUFSjNS+6len97McHf05d3+SCNgeHunPUsVlKt4btMu8uinXaXAM
         +CC0DdM5ZUHb3q2mYb5JgJo8ZNDVcuvO2YDrHDBKH5SexKz42MfXyxFpsStOM3Zinkl0
         7himkZeje8p7yK31oI/IjvhjLSfOxYX22UpsldwruDUN+SLZgB50u+1Jhm0PQjl1d5VP
         NbRpubxL1sGuyCq0Jg3HkNrj+qZZ/AQ8613fV/6M/cFRmf0ahKVXnU2D+I9pWx2ckRt3
         P+iQRZdmAqIwUwIXLgZP+RnTjswx7qXbU6TLCQyT+PWuyX17WjxlF1aEePJLabDls0U6
         kg7g==
X-Gm-Message-State: AOJu0YwGjq/l/MHduhTml80zrKEa2gPrjhL0FBH0B/IWRCSwwlptu/2K
	rfyTop3FA7wFCTfO28vVy0RfnKGrDUPz4FvGZoaKJFti8h870BuVl/DOEsgHWAM1nBtVY8K+AEx
	xoEfqk7MZ8epQtsuWXSyGDrTCEz00KoO9
X-Google-Smtp-Source: AGHT+IGpNJHzeZocInZ0gvTzvHfTjBYFYIZ5TzVqikKLMce/NXeBHk8nELxZ2Pb+v4rihbkGZkBUvow3pA8hV6dzeU8=
X-Received: by 2002:a05:6902:72d:b0:e24:a0b2:8037 with SMTP id
 3f1490d57ef6-e28936c779fmr8037014276.7.1728285699886; Mon, 07 Oct 2024
 00:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mahesh Chaudhari <maheshworkaddr@gmail.com>
Date: Mon, 7 Oct 2024 12:51:28 +0530
Message-ID: <CACTzyP9+Tx=iChdOETKPO0QHEjBGhn06pB_zwnf57suZ5aswUg@mail.gmail.com>
Subject: Requesting subscription to the ist
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Maintainer,
Please allow access to the list for this id.

