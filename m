Return-Path: <linux-rdma+bounces-9947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273FAAA6947
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 05:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AAB985C79
	for <lists+linux-rdma@lfdr.de>; Fri,  2 May 2025 03:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB218FDBE;
	Fri,  2 May 2025 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk1Cu6yc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A932D600;
	Fri,  2 May 2025 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746156157; cv=none; b=AbnxeEe0219aNeq1IZONB1HuFeYkUEUwcVIcoyhhLsGkqRn5WSDJTIwNEtB0AeefVLF//zfR2kQeRVSiymnTnFyDXuGrh65Y3wJgm0YiBB0Ie0dEmGq19OYha5Z+bHo2IDtvir3G9yes2f6Nw1o50DGwQvkCd7/xxO/hOTpNp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746156157; c=relaxed/simple;
	bh=TksLf5bS4cDwASVoWKhGuI200DaiWyfCbIGgZVlps/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFiD7QFIwJOnlBXGZmv4isIGOyb/wHOmVofWEVIusVnnYD4ObI3Cs5iAtP6AUgGJqNVfi0hsBRTCP81ORgH0Fy3sVyNhIQtZh/EkroTzvP2dUja4wYBC7SD1MOVlzdS+HfONFZqBMYUFHRdgSGgx9tdMHqqHV18fJlFTOHbMyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk1Cu6yc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33ac23edso18649735ad.0;
        Thu, 01 May 2025 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746156156; x=1746760956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+aBAE4E5Z6GkrNwFJ7Ke9demvrPPuBn07vQWF3n+iE=;
        b=bk1Cu6ycBHr79tHCCoTXk1DqQ84TIt7iD4zhrsTg31ZW+yMBrNgQABndz974FThi5Y
         eSMMk/U/o/VoTuISPHIUeLYeTwMdrNkZEqz4lfaB2tgsPJuLyFZqIL/dKrdFuMC6qiKM
         AbLQ1XVgBTPtcVY61F6H3UefusBjgMERrDHd4NXW+UV68fK6BYNX7kdDpit7sphsOSyA
         L785tuimPyuISl+DzC9P6sKGxf28Pjm5PtD3Q4iGy3j4h3ZWVC0BEMGf/PLYWlVPCKWI
         /RiIjlRzP6NPOC3bbQRs5eHPBenclKboL+n+whOzBiYh+pQm+/PPFhw8/z46+i5OzFmn
         ZGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746156156; x=1746760956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+aBAE4E5Z6GkrNwFJ7Ke9demvrPPuBn07vQWF3n+iE=;
        b=h/q2lZsmKoai9pVUpvrpq8wBjRmEjxh76wUlcbkqOjIow9kh/Xe8ER9OMG/HZmhY6q
         qI1SaVRkge5krWM8eSdEaBFpQDuMMXUTJBXnPwYxSVlNI6sIzc0qunRwnBJce4MznV4T
         HTzD0gnb26UKCx/MikLfW3ob8Q6hAj7Qc4n2UyCnoZxsGIpHULnpfyXmWS9ZgNwZ/yaY
         ARYy4JnpAyBDJEoZb8o98Y9g4pf1yUeeV/r2wbxsJWzE595a9FxE+2Klt2yJDT05fQug
         QInqx91etLLFKDY3KQx7lpb1lnUvVL8xMk1qHeIaLG37ZElV/STrejeZJQOKNgV1hyJ4
         iJvg==
X-Forwarded-Encrypted: i=1; AJvYcCXDwGpe7hNJLFwIlqTMBCnXTcyzQK4EZUosj5TeIVYSwDtft7D9uVDK+yOG7aX42PMJBeOpgzMtD0BN@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNQw+xgmSgVEU3sHg79JAm0TpoJ3VtirXWljeiZ6kzWrjLqen
	Lk8UGvFaUz2Q4AJ2Inz0H6/UKYIDidBtkfE7pqvr4ucoiV2245rDq3NQdPxv/uI=
X-Gm-Gg: ASbGncuPetaTR7+i3Ucq5bwK1UAnceBx/lwgWyAylZ2UbVePFdIx+CGLE2k5IuSpCEO
	L18PdA4RwPJy73ZR1heGZhS0NIpcpoOrNLihQ3+Yz9tHwufqpx2U1DHlrN2RnaFYj3300PTSkTK
	1p68RolT5xJq29SIfYOJpjhbavqrTnl+y+/u+pXS4oXYEPkc/tQZ3HdHIOisFBIgGE9XZG44p5z
	O8rPif38VjkQzgJip+ITzrxW3rZ57gMGUjvWdvkhPb3DlQpdR1D7hGiTOE77A51V4YjPPDm3rYk
	Ifoh47w3Mtwc8MUmnL+k0es46do9GK3l1ivba0frK0gz7Cz4cEskwcCjKhCuJbX6HgFYgzU=
X-Google-Smtp-Source: AGHT+IE7MQyACU47LjcLSVkj/QeuCuoxt3MH95JUF+/SVFqw+60d+bRfFFz4OyxcKZ8otnWz1dMnWQ==
X-Received: by 2002:a17:903:2450:b0:224:249f:9734 with SMTP id d9443c01a7336-22e1030c9a3mr20763285ad.4.1746156155830;
        Thu, 01 May 2025 20:22:35 -0700 (PDT)
Received: from trigkey.. (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1094063bsm3974625ad.248.2025.05.01.20.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 20:22:35 -0700 (PDT)
From: Daisuke Matsuda <dskmtsd@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: Daisuke Matsuda <dskmtsd@gmail.com>
Subject: [PATCH for-next v1 0/2] Prefetching pages with explicit ODP
Date: Fri,  2 May 2025 03:22:14 +0000
Message-ID: <20250502032216.2312-1-dskmtsd@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is ibv_advise_mr(3) that can be used by applications to optimize
memory access. This series enables the feature on rxe driver, which has
already been available in mlx5.

There is a tiny change on the rdma-core util.
cf. https://github.com/linux-rdma/rdma-core/pull/1605

Daisuke Matsuda (2):
  RDMA/rxe: Implement synchronous prefetch for ODP MRs
  RDMA/rxe: Enable asynchronous prefetch for ODP MRs

 drivers/infiniband/sw/rxe/rxe.c     |   7 ++
 drivers/infiniband/sw/rxe/rxe_loc.h |  10 ++
 drivers/infiniband/sw/rxe/rxe_odp.c | 165 ++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+)

-- 
2.43.0


