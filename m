Return-Path: <linux-rdma+bounces-7220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325FA1BFAC
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2025 01:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E461886E5D
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2025 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F3A1862;
	Sat, 25 Jan 2025 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KrMYglP/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4C17C2
	for <linux-rdma@vger.kernel.org>; Sat, 25 Jan 2025 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765047; cv=none; b=OJxein3cCtHX0sxpLKi3JWwp7V+AOOpGeo/4QTzK/gla7SpqfHKskazXvIQBUrg8gtuLn0KZyk/BxGgQK2IKOL1XNz0BG9YR/pmfWdZMfZ8O3yDiYtjP+FLXJdhef+Z8nj3R5RdtQs3TnAjR0ANrMp7jJyThwNdUiFmyjEtYYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765047; c=relaxed/simple;
	bh=0jvMjG4R7HdaYu0WXH27Xgb8ngsV7nAeJXJowvQuMRo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W7tuha7UaRZWvOm2LjiIK3dmz/fQkM7KJwkCtwyJ56RQUeS3S2mchC6YrTxTuGDjQS2vLFzcPmD6NiGHUKsHzEVXuTGa2Daf6rt3+zN+RdqVX4CUgoBWL46Fj70PfaO3WkOMEx/eHs+3AMfLqprbWGTj09msLsY4mOvLHcQZnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KrMYglP/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dce7263beaso25672126d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jan 2025 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737765044; x=1738369844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0jvMjG4R7HdaYu0WXH27Xgb8ngsV7nAeJXJowvQuMRo=;
        b=KrMYglP/wMC6PrDhnDcGJtKfMkbmyCAZ8D5NrgNqAJpOJvVd51bxbB1VUJXKRYOTw5
         BfS1RsTVpTsqOKO8u8r3KWLbaf3sAUzi87PEwK5Kd91FmO66uLxQ3JgEeheyi+1KErDV
         iquzEx3z84LvpLldcOwYwT63pIib+MQBTGOftYtVIIDz+zEVL7eIALfH5fT41gIk9HrD
         twbM0B8aVmsglbLlD9qCDkzJiC3T7ge1VsBA4eYPokYalZfqh9CVhGgn9ZMUoC3EJVTK
         3IN+Xbe+P5kvgyzvPzFpszUaGtvEkhYuUrBPCi43+Rh2OuZeGwB0XcJwM5gh1QRxMLck
         +Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737765044; x=1738369844;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jvMjG4R7HdaYu0WXH27Xgb8ngsV7nAeJXJowvQuMRo=;
        b=my7q8gusWraoCGUY9zPKLxOfyUjk/KACI1XnEjl+Fcq5sF9QulfIWwBg63AGBLdekn
         q8AmmG/o8Vg2oWFbnMeSElOCHKV6Bh8fi0p1JdVJQh1RiHQmRsO8mzg2MrDQDXQfZRZb
         cuUf6CZhnnhhi6BH7AP804svyddstzgYLbROE21H9RvyDpz8Q7k1zBQ0Bpp2UUqQpMyi
         8r2dPfcT+yED7E8oghYxzASIMzCWoCcdePY3345mU54oswpmVs89s8+m4Oo5rGDsptnK
         sCrSDjI1t6xSHqKTmjQPsct8XK8Mai6bJh6LUPOUHE+jAQgPpYXooVOmb7jTZNwYH4qQ
         nKTQ==
X-Gm-Message-State: AOJu0Yzx7rD+dUz7IoHDKh/19EPyqArK9evj8igA9JhZMZE4SBnf6rYm
	bcrB/vAz+/cE6J5oGmtzwxbVP2C7NLubdivTunvVHEGCPgnZyUHzEPolToUxT+QcRmGWuRBheWi
	S+buyXWIvy6Nh18DyfcDVUafxOxL1kPAFl0WB05KT8cK8VfOnQYQ=
X-Gm-Gg: ASbGncvPQL16QYdrN9uF18oK1UVHcUQf4YfM54mWDdqABvNgAnNkP+mBkFEdhrLG8xA
	wQKefORxK2oxsMdcYHgiUG8MiBxId0YMQK/5IOwLH3A6SX875tw4BgFIWxUkofQY/
X-Google-Smtp-Source: AGHT+IGtJhMl/8/Q9qKOcXuDbMFbNcPEyugX7VwNbp3Vj9YYICUfM/T4P6U3pVF2QInMpK+vqqw1A40dCmIHM1RFPxY=
X-Received: by 2002:a05:6214:501d:b0:6d8:88f2:b4d9 with SMTP id
 6a1803df08f44-6e1b216ff66mr450915046d6.3.1737765044303; Fri, 24 Jan 2025
 16:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rita Han (she/her)" <rhan@purestorage.com>
Date: Fri, 24 Jan 2025 16:30:33 -0800
X-Gm-Features: AWEUYZlLaIhG2dQtMZKIbLNlWSMJXOKJnTq-gNIaZwwun-FQiJZwnNMTPi9f5X0
Message-ID: <CAJGGzq9AhXns6y4i5LBY-g0eQY4JSV=3AG4Rt6-eMhNtE7fu4w@mail.gmail.com>
Subject: Handling RDMA_CM_EVENT_DEVICE_REMOVAL in rdma-core
To: linux-rdma@vger.kernel.org
Cc: Matthew Carlis <mattc@purestorage.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am currently working on validating PCIe DPC above Mellanox devices,
and I've encountered issues where the device does not recover after
injecting DPC above it with ENOMEM returned from rdma_create_qp. It
seems that the rdma-core library does not support hotplugging or
handle the removal of InfiniBand devices
(RDMA_CM_EVENT_DEVICE_REMOVAL).

Are there any new patches that address this issue? If not, what would
be the correct approach to handle this event or recover the device?
Would it require us to free/destroy and reinitialize the device?

Best regards,
Rita Han

