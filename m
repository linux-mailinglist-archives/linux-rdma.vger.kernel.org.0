Return-Path: <linux-rdma+bounces-9974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1707AA98F7
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECCC3B54F5
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F96268683;
	Mon,  5 May 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIPWz4Gw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE83269AFD
	for <linux-rdma@vger.kernel.org>; Mon,  5 May 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462606; cv=none; b=Hky2y6INrEuEg70G0+ZPobA230NsaOMyJSbldZFQsxS8ZwTn8pUlS0m0meYA5ITwb8LGZw9CVxgctNKAjijrfkOdMJXJBXCoIgmRtHqzBXR+/ERQkY7ea+Pa+Ti7JxrAKIlGGPshD1AnyuZUGIiVPR0JR2VHx/PnTz2v+rA0V1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462606; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AgiVVEecH1Ua5SBnYYBv3MEnvdGpcfhTxe6/thv49u1iJfXfq263QEXWeR/WeuBAQnQMa2qKUXTrRK1PxCTfm1ySe/JOtksKF2G1T48DHGO4VEcy7MBlVOgbdCGsBCkRNu5MgJjR+dx4VWsGOHlkVlLwOsEMugaoMf60rdszxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIPWz4Gw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39149bccb69so3579161f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 05 May 2025 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746462602; x=1747067402; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=cIPWz4Gwr8TkvGzG7wtej10QH6rgbAgdy3o5OaKdA1TD2DRfwQnK2/RD8+Str8jRWQ
         Vsxmua0RKOp3vAZnJeevOaf6YgrqYrZTXklM8vtuTw8Dj+PYS9prS0LkPi3PXhaRGMwY
         fwG2Xa3z6rTV1mepY5sABXhI5JIVN0WzjHa2okNVY+LTTE4jA1XvS6cN07okTiFD7sTI
         woTsxiV0lYECMsFqvgwp/GCQRwTbWaPUQbNwsQ001yIyfxrJ+fMuQDs6gABgW+KI+8Mg
         jtqwD18/VnDZRrcZHTtnf0wU7Z/A0JYCQRyVGAloMVX5WcVmucylYw8PYnyZnJTcDeXO
         62ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462602; x=1747067402;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=IUM/3bvA5EcJ+MwED2TN4cX84pCWSjmKDu1T9046qY1BS8xM36+uM2TZOLTTisY3zm
         9KZkvAvT04XG9uQ5F5ORuyxzgJOFcCgHA7r8R0Sk0o5hwf6DWoswLCloLxSbNpW0Lu4J
         UYZsBJfXU4w0FNVwNE8avT0MbcUdIT9LyP0Fv/jkMLSSZnfNWLkkJp7bMBl6n1NUjOu1
         vQiBxbAkS9ZOBYnGDyVr/6BcRYXXTT/KGQvZfwz0kfsIRvUU93B9vnJmtv81y5Tw561q
         jV7rGENkkYC6nYHpEEYYg46JSVP8+kabV6Ng8/NG8aUNv/rK3hkPYgScbypD5Y0rNtt6
         AItw==
X-Gm-Message-State: AOJu0Yw1mNoJd//OgZ7IzXwybmWBOotNXtJDBa4gVeXtvoaugtAHQBZk
	oIcnafgXe56FgxajSjlVZsvWQz6e0vsoEeaGL/62KNdc7XO1BtB2JlXEvDVu5md3JJiCnQ6+m9D
	JHg8oHuJw2dd2I7CUz3IRTyedrdKLjQ==
X-Gm-Gg: ASbGncvkjQr+gRKL0JNyMPWmGmjd7MGlxK6udib3GGZKO4Sx/ONRZvDIdjRkUoZHTxl
	sePCX4l0VBA29cOC56a414npG9T1FtAlIwSl1Hsrwz6D0qVxLwMBbndDcV7gnT0gxBaU7wTNg1R
	CWiEC5saC92vxFFx25Fpld
X-Google-Smtp-Source: AGHT+IEvDqE1mwOOvyWKmsH6pUY1cjOYvzXy12okZYqst2wNGCLAEy8EaYSQT+I6j5wB5Vvr4EX+mDVxnckKeRjpg5s=
X-Received: by 2002:a05:6000:40ca:b0:39c:f0d:9146 with SMTP id
 ffacd0b85a97d-3a09cf33aa3mr6587107f8f.45.1746462602629; Mon, 05 May 2025
 09:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sivareddy kallam <k.sivareddy@gmail.com>
Date: Mon, 5 May 2025 21:59:44 +0530
X-Gm-Features: ATxdqUF8tpROCL93HrYSPX2GBLGcfEqNRKqDTHyzkEukAHcsxRmpeJCOnY7Z150
Message-ID: <CAH5_UQmR3dRUne60=EkfZ-ecwRd-ZxHcoLxiettUsx0rcb6NYw@mail.gmail.com>
Subject: subscribe
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"



