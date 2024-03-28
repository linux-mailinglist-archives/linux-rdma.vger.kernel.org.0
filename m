Return-Path: <linux-rdma+bounces-1627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5BE88F57B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 03:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5981C27442
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 02:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA249224D0;
	Thu, 28 Mar 2024 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOtygqE+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012562BAE3
	for <linux-rdma@vger.kernel.org>; Thu, 28 Mar 2024 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594055; cv=none; b=nPsHmsXwQVQhKNYxT4Hvxd/+PXxlj/luO6Ox0OjgVpR09tl0bkChwXKU5ziuQohJ8Cc7cw/GigltYNU7T1tcx+GXHonIxzLgG7Bg3Yk3MX7GCebsFxMOxx3Y3yp/DdbeQpAKA79MTr9i1Gi7zbJMlQf/Q/6wHytvnqLLJNuM9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594055; c=relaxed/simple;
	bh=zUFyT24/aPGyZARqN56FSC0aSXM/PdSKupaqAjyYcmg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TdqLaUiqHP8Q4bFjvyLPJCW9ut6V4GoN+rayVh8ttXuqYklq/E7il+B9aWgZzxUbhXDrO7gW6jUB5K+de6Yi3DL0W47BVoDtsOL3S+0QAIjYWRH9yPFfKB61JwMG3y0cdQTOOVbYs9+6BOzM6AfxdUbdOETWtuuTf3CE1r8ArN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOtygqE+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e89d0816so471821e87.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 19:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711594052; x=1712198852; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=abd4qDsmdJgwHydhboFDHuj/iuC9vclDsnxdl9DcGbc=;
        b=mOtygqE+Vucnk+IMby/r7KlSXKon2jxKXYcUmi1tLldSJ46jKl8IkW7MFPQg5/54+X
         itE/yiYV5MxvSmM+ZDByNW5xP9cvycsa6JXJ6sPFFeBmw9IG/JAR7PTReC8SbVxFkHTd
         qaCmxRCZpBp5eGaBj1Jd4gpIUbrPmSkpVkXkg8+PZwRz8WNYnFGCGaI0+quDvB6tntRO
         pTiYzc22IjJTK7ikLulVJdYZBoLYRTcRf5Wiw9SQOdD/Hcg5MozqaxX/H5Jw684SILRX
         XzGFUOnANyeOWDXE3/jkoxBDk44qUmlJ4O9WUhzgv144XEa1siMjEjCtLs1HZZZO2ZrE
         eILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711594052; x=1712198852;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abd4qDsmdJgwHydhboFDHuj/iuC9vclDsnxdl9DcGbc=;
        b=qIC9WtafQ6Ut3KA5PMWuZkF8aCRfnXYmN7lYx1w4xenzRzuemLiHLG6qFYXWtYOFT5
         N35mAd3OH2n2Q6r/LZRpGlS7lV2HRbOHW72aIeNIr4c5/HRc+CkV0P1n7Dt/pwFb0zEF
         7K//6tlQduJb2P2je77dEUd4X0AlaSiJsAd9o37L64MRokhkEVGXVKYLwvD83FtgeAxW
         18f+GsNElFI+1Wu9VufiNR8in49ov7SBL4ThW1mzfZzjTHDZTVQYj8RhNWG40xF5JayX
         cfPnKXVl4+8qhyQqYeBd/T8skRRVSH3+BFWdfczGBVsNJUMh65dMxzgViNptKAPyzGBG
         waNA==
X-Gm-Message-State: AOJu0YzhwFZVC6zfjXwHyNc8iTHrT0rVimLMNVElF7DasQh7U++U7jlX
	Mg4PEWTqv6tOSIQx8E96ufOzW0e2vWOpt8aXNaA0EvuRJEqm7KcijX5jpUFzq5UTBPz+d0E2b/3
	voIzXVYHhkfsVHiG3menwJLxX4YnXkaUeHuFJqQ==
X-Google-Smtp-Source: AGHT+IEbPEcZTIyEAZUbTFaR24ZR0JzwAZ6bK42hZ7W+g84zK0Bl1TzbvQPxIVzK0N84CZBal3za0C5MH4g66TA4HEw=
X-Received: by 2002:a19:ca4f:0:b0:512:fabd:8075 with SMTP id
 h15-20020a19ca4f000000b00512fabd8075mr752958lfj.48.1711594051761; Wed, 27 Mar
 2024 19:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jason <huzhijiang@gmail.com>
Date: Thu, 28 Mar 2024 10:47:23 +0800
Message-ID: <CAOTeD=CmX25wj31tSa9_u4p+8J5KUeCbJZ9KMf1o1n3X4xH1CA@mail.gmail.com>
Subject: Why do each node have different views on the nodes that rejoin the
 network in a fully mesh RDMACM configuration?
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have four nodes: A, B, C, and D. They use RDMACM for full
connectivity, which means they are both servers and clients to each
other. When the process on node C is stopped out and restarted after
few minutes, the other three nodes act as clients and initiate an
active connection to node C. However, only node D successfully
connects, while for nodes A and B, connection failure occurs on node C
due to receiving the RDMA_CM_EVENT_REJECTED event. The status value of
the event is 10 (according to IBTA, it means a stale connection). It
seems that each node has different opinions on the rejoining of the
rejoined C node.

Even more strangely, just after node D successfully connected to node
C, the connection between node A and node D(D as server), and the
connection between node B and node D(D as server too)  are almost
simultaneously disconnected, because they received the
RDMA_CM_EVENT_DISCONNECTED event from each other.

Could you please help me check what the problem is? Thank you!

-- 
B.R.,
Zhijiang

