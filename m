Return-Path: <linux-rdma+bounces-1574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60DA88CB2D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B2F1C3255C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229420B33;
	Tue, 26 Mar 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhfKESeF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927D1F947
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475081; cv=none; b=RdrqnOdQb4cPU+XVclgzxJbW0F0kZGbwatifEzuXc/3rzmmfbnaKJp7OuDoVCPjZZXlz8s4mdX4E2D0qI507CYLwyNX0ibgAArn3fi5OfLrYOWJjWere4LlHnN2sGfhHLltSRlcAnoSQOqKs5DG+Y4hUdMWjMw+GtQZwZvk5mBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475081; c=relaxed/simple;
	bh=zg0NyeYEpLuB4fyjuE3MvfLeRVPQSd4yd1s54JV6GWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzAzXsPJbZniq3XacvE2RjbE8thHNjv9fL5jrL86VCxnggS60FLqoGmKKkJAgHjUfUe/DgmToQBHSOW7zK4VzlhQbC4y138qsuAGV4fQoirDOJlWpBqruQYQtBZLVLSR5RDXIGNgYzfh4540pQ6u8UNn6hY8LWoz2LnJFlXQNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhfKESeF; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a492093073so26367eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475078; x=1712079878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXh7V81ZGQZDnKxGumMU/gHX+tc03N1++sgZn0l9RzY=;
        b=FhfKESeF9k5QOE6I+DxCE4kVItTt9jlsjrFclBtWN+yasmkeG/U9bWPo3XeY3ae69q
         V8M8EsVUi2zyzPiuxoiNxYRNhfRuWJrRmroFzXk6dJoTuYGyVDaK6fZPVWzV/0qRed9v
         TyWYIT9BXh4IYJ7CzTu/C63eIVFpU7RQWn/69FniREhXPlABolViTuiAr/53dMgutUSS
         kQjp91DROdq0gSfAqCJ3K7lGlSj82WuPFc/HjKLAgQVK7KI6eEGtSLHNkIXec2QhNmR7
         CgDUT+zT58w0ZaKfypm9CSlttZs/4RKzv0SdSBc5e+9mgnE27ETwoWk+ozJBcQccNH5n
         /IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475078; x=1712079878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXh7V81ZGQZDnKxGumMU/gHX+tc03N1++sgZn0l9RzY=;
        b=uakNwfrlb5bFCXkUXk/+3pinyYnA0PZk7pLFiz3dLBXT4VcdpQz1mrsf3Ia5OIrfqG
         S+vBlcx3gx2MiPQfsQxKPDaxxFEsYbj0SVmd2K8kbB4YZ8qleaN+oiaqFbtZrc702XQe
         OPbItXp5MxSECHlFjMUmrmRVrNmw/kuUFwEzrlNfHOvyJWXngSeqxCFaU/H6RC7lVS27
         YDqrNeO4WLbb2kmgr6k4MZJdFw4PeqPnnhyDAKrrU7oQVWnutEuqrjBFJWqVRlNQA3Ix
         3672f3dF9lqXwvTLXwXytmNxYpPtiQxVQVG2S9oNFLVOBM8mkqIPAfPqy8IejOCTiuAI
         cj5g==
X-Forwarded-Encrypted: i=1; AJvYcCUq7NJ4AHDx2FgqgR2km/GFlbjY6yjtWPp38p8p6Hr+Z8k63zSYY9xy6D9qdB+bV3L/GPoTA9wGZIL1XVt4gh2XAxGfaK1VfTdJqg==
X-Gm-Message-State: AOJu0YwkcicXh+96TB5ZbP0JkEZ0eVlgVhfExA6Ahp/c+kl7ZGykutzS
	qXwzb551IkcvlqsJ09j3ATi8XFiQucHs3VsVvDa69xAu1OAjVOC5Bj0efRmO2tI=
X-Google-Smtp-Source: AGHT+IHEupCyYgn6WDzELXPYMlX685NvELXg8zFN8d4+eYiOZ6BpyVfKesaYVWVDkChk+aA4UhwX/w==
X-Received: by 2002:a05:6820:986:b0:5a4:5526:1740 with SMTP id cg6-20020a056820098600b005a455261740mr972890oob.2.1711475078670;
        Tue, 26 Mar 2024 10:44:38 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:38 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 06/11] RDMA/rxe: Don't schedule rxe_completer() in rxe_requester()
Date: Tue, 26 Mar 2024 12:43:21 -0500
Message-ID: <20240326174325.300849-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326174325.300849-2-rpearsonhpe@gmail.com>
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that rxe_completer() is always called serially after
rxe_requester() there is no reason to schedule rxe_completer()
in rxe_requester().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e20462c3040d..b217fa94ff03 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -631,12 +631,6 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	wqe->status = IB_WC_SUCCESS;
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 
-	/* There is no ack coming for local work requests
-	 * which can lead to a deadlock. So go ahead and complete
-	 * it now.
-	 */
-	rxe_sched_task(&qp->send_task);
-
 	return 0;
 }
 
@@ -760,7 +754,6 @@ int rxe_requester(struct rxe_qp *qp)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			rxe_sched_task(&qp->send_task);
 			goto done;
 		}
 		payload = mtu;
-- 
2.43.0


