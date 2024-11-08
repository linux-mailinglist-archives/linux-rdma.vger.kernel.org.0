Return-Path: <linux-rdma+bounces-5864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDE9C1AB9
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 11:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3023B252C3
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCF1E573C;
	Fri,  8 Nov 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3xvD6Ha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD5B1E573B
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062014; cv=none; b=oRaiOBZRw548wxzZ9L9UVBD4AMtigf0GhGXH9g+9/9/1u6XVFWqaInQustLmMlFJnPnQuVuhUTE99DFGd3eR8etv8yveivxlBX4LeBYt1PcTrnqA5Yfm9sci8DGncB1CGIRjQxcBntvy8GP+Z+SRl1tUjUpilvvFxMKZZPNNAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062014; c=relaxed/simple;
	bh=UrOW+rYPNT7AwPYOxWlOLy264eXRGPGUGnZTuq8z3kA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rAs3MrJQuTmVmogYOepi7BPMDdgTLM+3yxgO4+uWaqPHQe2nK5tQhHyn5ONWFovVAZX9t8cvFgBN8fV9uFtKrIXZI/ywa9+HMag4Tn57Ytinr/m/hpZ7YrVmjVz8sbXaUGc6NMePbR76BUGvxmJBUYAvmgU0gLKzX1ctADmdWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3xvD6Ha; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1758940e87.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731062010; x=1731666810; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UrOW+rYPNT7AwPYOxWlOLy264eXRGPGUGnZTuq8z3kA=;
        b=U3xvD6HaYwQJVC3bnW6hdlCzWWWcCM16uk4Nx6x/AXubvhthf1h7k1xTev9wfoC2F5
         Prop7zcGjMYv8RE1j+CCtQbNbOWpDIpHbq7TvF+Gve5XeJbVt5WGIQeaHJeLxumG5oE5
         r1a5p+eJA0P463QMXECG5fLl0ZhCPGP0axhAqOU4urNudiZn9uIzj6UrE1swPZJ2tT+O
         9z9YloRTFnjrx5WorKvdpBvTTAP28Ew2aUe2oh2kwxKA/FNntzXt1gLG9wUiIbbQ1J/7
         +zyqlvw34WQHsvx90cekgJ1+F4vkmoni15EBE63XdEHQ0rE2KRAGRB/py71TUTfzrd3g
         luuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062010; x=1731666810;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrOW+rYPNT7AwPYOxWlOLy264eXRGPGUGnZTuq8z3kA=;
        b=pd+g5mj1L0kuGGAlOp9rwFFf21RY8vRDiRz1EiME+kb2FzUfo0H4wk1DnVQMuqFsGR
         iNEWjpENHbsdi9xowVrSg5+bJluH0gwbdWR9sf50/uFKHv671+P+aWqtsC/WoB3t6kWx
         UM7PRDBppY8bjxKmVSJT2QpzMmWNQqcMsV5YPUYkoVWG0RV300e//0IrxxdSksy15kJo
         aNdSYDqFyf7yn9E+ZwaTiiGF1dDDHvrLcf3zV22oC8eihFF3D04iR8RiNztBwOhdszuR
         MiI9CM/m1AzHN8koRmR/cSw2xRopLnPNxMMHpq03OMs7JqKhxf2WT1EgUrCmw0JdgRwT
         FVgA==
X-Gm-Message-State: AOJu0Yw4omwt0e+pGaYz9JWGOReVI6x4uFbqDF9RogEj6xSi2YNf55Xf
	r4ocZ5kj+yronp1TpNu6CmxmXjNnvYVtf+UfOn/g5kUVX3ZzFaRxrCVhUOXez0og1quSjgCgjwR
	GOIeFY7ALg7iDh43Jch1nQlXlX9+crGm+
X-Google-Smtp-Source: AGHT+IGDPB6n6ye5Y5NJpuJUnUOHCgCMu+9+5AEoCcqpF39XR4sunLT+KeSU5VYU3Dc6WDvieKk1MsZ/SltXDCVYMSU=
X-Received: by 2002:a05:6512:3e0c:b0:539:f13c:e5d1 with SMTP id
 2adb3069b0e04-53d8626c083mr1344025e87.38.1731062009846; Fri, 08 Nov 2024
 02:33:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cyclinder Kuo <kuocyclinder@gmail.com>
Date: Fri, 8 Nov 2024 18:33:17 +0800
Message-ID: <CAL8qZ1Zke2gCfNyC+qbsg70vYs7ycxgFMb3P8FCtzcERFLjNXg@mail.gmail.com>
Subject: 
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe linux-rdma

