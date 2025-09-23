Return-Path: <linux-rdma+bounces-13610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC2B97ECA
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 02:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF2E4C16D8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 00:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637461C54AA;
	Wed, 24 Sep 2025 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="GuF5APrQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0E1A23AF
	for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674622; cv=pass; b=k7BAN2P00YpxImrfIomgk7KLxJft/zBHj/OeiJLx3FzmGSvg1uHnEqGxvwY2EsNS25A/Lxdu5UIkETpbwlbD84aI5D9eEQvkOYuNSFA9RF8m7hAr6fCBR1vZbCKkg9ePAKM5JZLD8vvPO/9d+VY3bHDeyoZhjrtOhG97ZSVWrR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674622; c=relaxed/simple;
	bh=VCtXNDdcyx4IggrcwtHubEdfyEhdAI8/Dvo/rJmMNEg=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=oNLaOGurJ5aOteOFOV5B1n9opK1YktDWuGl2yhAGa2BXIYKFph8L7YygKKOenhENu2S/rz0Maj8FsC49PUPtxF6CrTrjCK+D6MCOqyODiauyPp4WZne/B/kycZBg68iUcano30EG+oCcl8CL0z+jScQtOhBMBA8yGr7eVaC6L9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=GuF5APrQ; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674619; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=NVdZ3U5ZN+2dIsmlUfcG9fuHJyyNPKegE48jM5Srqh41cFUfjZiATNwxBNJVyjrWTHQXf6E/mQYDpZfwQNj5CFLZXvxPlSng0FT93wKHReoaIbCgdCxq+36WEjgy7eCw3BUtCvTRBDuOhOvI9B7Ot+DlOh5QH6C3SQG7Jh63frk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674619; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=VCtXNDdcyx4IggrcwtHubEdfyEhdAI8/Dvo/rJmMNEg=; 
	b=FCQI9zVfvL8qfnd56tQYfKeRWzvFDhg2G68QtCO3hxqXNgur6phdDjVSThy3J/lNRD/1kHCNMsPRm5KDf4FQ6IY1aFLQt+gjNryF7NWn1l6Xi75ItNx2GB6qsF9K+8P8ob+msfWI75D5i4he7uEInrsD70nVWDiEsGHbZ1bDFXg=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9aabbeb0-98d8-11f0-9ce0-52540088df93_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653186869.5677730041249;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=GuF5APrQOyudA7R9d+xn8p18vuV0+uejpKCgjD3KqUDFfD0N0SU5Ugi+l6rqDms1nmI6xsXpo+5pNx5oOwUQn8tvWkPqJfCrNiGhwoh6oDX2mgoas6qs4v2m6pDN2rL1WWmkv/v3qY97Z7X9/fb8E2Y6HlqvPYcpnhqXOIg8BBY=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=VCtXNDdcyx4IggrcwtHubEdfyEhdAI8/Dvo/rJmMNEg=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-rdma@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9aabbeb0-98d8-11f0-9ce0-52540088df93.19978ffc61b@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9aabbeb0-98d8-11f0-9ce0-52540088df93.19978ffc61b
X-JID: 2d6f.1aedd99b146bc1ac.s1.9aabbeb0-98d8-11f0-9ce0-52540088df93.19978ffc61b
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9aabbeb0-98d8-11f0-9ce0-52540088df93.19978ffc61b
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9aabbeb0-98d8-11f0-9ce0-52540088df93.19978ffc61b
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9aabbeb0-98d8-11f0-9ce0-52540088df93.19978ffc61b@zeptomail.com>
X-ZohoMailClient: External

To: linux-rdma@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

