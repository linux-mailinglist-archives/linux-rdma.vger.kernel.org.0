Return-Path: <linux-rdma+bounces-9472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697CA8B117
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D843A7DED
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 06:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749912206BD;
	Wed, 16 Apr 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2fGiVfh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99403207DF7;
	Wed, 16 Apr 2025 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786241; cv=none; b=MUsjE9iG3usVFeAUV4mXg6YsdObG0NL6LJhlxaTLkhONNiQUow9gsotR8HCU41Q3jitN1RYUCpfFuBa/teObC/twwOCIYJ2NWkJtR6f1lqmR5kW1Sg1mvSQJizkugZ1+Gm66wdN8Nv0qhWMMiY2POhif/p4rYudiLlsFR5sCIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786241; c=relaxed/simple;
	bh=B1KKRwM2trU1CVGyeOoOABBXy1cregEeykhg280smrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWXTjEvHtbZ/SYWQgvtLDngzY9AGoi6N/m0QPFD8/w9Liw+A0Mt/jPyBqYFBwu1woK06p16t0bopsXwEIdOgcYOt4Fd7qGyPBuBsqlM6nH19CoESqqhK2OoayoAfG5ZJiv9qw5/mp8PsSKR3bcHMZPOm9PsMSQtUIadnhiha8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2fGiVfh; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5499659e669so7621342e87.3;
        Tue, 15 Apr 2025 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744786237; x=1745391037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1KKRwM2trU1CVGyeOoOABBXy1cregEeykhg280smrw=;
        b=W2fGiVfhV1B9saQZBJnY1ruSh96jkzc71+FKec+HBZo8nuuaBQ5rJoLYW5pyNEQ1Fj
         NbsJV7VxwED61U+CZdUb31iN2AGkAwdWN5ii6nDwinRzFMcPF/hSoHCG5M5gbIvm4E9X
         ArXnCNpWGb94BPsaQAbVwq4Oy1T/h2VRnrU54o8ABA7BIOpWRFbDhetrKT+Ok+d4KBsP
         VAP1/c35P/nHLJUO6AS+ucf9+mRk2wD3UfNSqoYa8kFkCNhFHPlYYtV1TJpbhiW06Yqx
         fJCUB/V/fBYpFPy8pbYL0gf+nu/W42kxRW1moHKLPXTvkTxmMbyC1NZelNWvQXX/VRR4
         ZwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744786237; x=1745391037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1KKRwM2trU1CVGyeOoOABBXy1cregEeykhg280smrw=;
        b=lvp/oln1JERzKkUeuYH/gBGx1c6OltaJSigMsPlZTSzvHaT+0PZHlxr5XDJjWgrvJ5
         Jcv3FpxNod8CDqcXihlMR/cZOWKwRaRo0CuWWIo52Y0+Tf8rtmqI7MhvLk+0ERM6FseY
         HE1vrbGtyvtTmEszVr+AHUyHY93DF1Up+0oxF3OoNG7q72IsXEMtK5JND1TdsLvxHK/8
         P5Hqp4pk4Ek8mfGKUVBkiEFPSHz9FShH1OfHCCmZLUpsbSJxKSXPpwj3laZwCZOoYI2H
         g1yAKxAmqEgsNY6JtXzNKEnRxYSa3ygrg9DWG3i7G2wXoXI1cqaBTQpZmP312oyEF+wQ
         OWPg==
X-Forwarded-Encrypted: i=1; AJvYcCVUrYqw9UPHk8AijW3V2AD5IWiJBYy/YVw9FWtHu9LADQqXfFa7NfPVFRf4kekydCXWkvt1yKCX@vger.kernel.org, AJvYcCX3JE77OLO2xAcLwkNAzHYw992CFXzairI+VCSsaeVFcwmZKFyOvh/zdSoaZZJaPi+pqG8nfu/tZ6JaDus=@vger.kernel.org, AJvYcCX3U5Y8RtqPjDdxwId1qVjoursanSE8ko36vE7kHb7kYYVki4SPgv3zWsjFUGwuR//AUVHYB7PhkEbF2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfshGLWmu7KwDPq9wm4OJ/leSomh9LF5/tJj1SexQjRvrsglR
	unYM8iPz9bfc6vc1RQcw3A11nuwjOdUOAnxAiMgbwBFeGMqO3MLrtc7ZolPNO7YtyEAB/lhyZxB
	OA1t3W+jj9rq5X1mgDRx8ah1BCCU=
X-Gm-Gg: ASbGncsgE9pUV0U8hDPl2E7eeTGTP4Yh5qbG8iEaOHaqozhw224BToGucaOBGl8XyrV
	1DsK6rnmsZqia15A7sd9oTgRkOURyPbIBUuc/zheh38K9DhF+VVukknUctp8hywc2g6dE/qOZe/
	0tyMz6jQpUjOBENd0EM5JmfQ==
X-Google-Smtp-Source: AGHT+IFkUl68vPRq3Eoh7lTjnZsGM+ezWLD4qM9I0vkyVblUK6mahjlvr+SHWNSVM8wd+7zn98YgfcXamDumw7iE2ME=
X-Received: by 2002:a2e:a5c7:0:b0:30b:c980:c589 with SMTP id
 38308e7fff4ca-3107f6bf415mr1948791fa.14.1744786237122; Tue, 15 Apr 2025
 23:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415124128.59198-1-bsdhenrymartin@gmail.com>
 <20250415124128.59198-3-bsdhenrymartin@gmail.com> <c0125e86-79f7-4217-832e-44249cae16dd@nvidia.com>
In-Reply-To: <c0125e86-79f7-4217-832e-44249cae16dd@nvidia.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 16 Apr 2025 14:50:28 +0800
X-Gm-Features: ATxdqUEYO-wItcyAq0JOiMYlpEM-Jg-HBC1uyFcYUgvgHxfq3Kiv3jhkqgwAjWQ
Message-ID: <CAEnQdOrvtYPghA1=4t9HfP=jSZE=2pHi9jR1mWyJgCNCPEG5Fw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] net/mlx5: Fix memory leak in error path of ttc creation
To: Mark Bloch <mbloch@nvidia.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, amirtz@nvidia.com, 
	ayal@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> What about just moving the ttc allocation after the switch case?

Thanks for the suggestion. Moving the allocation after the switch statement is
indeed a cleaner approach.

