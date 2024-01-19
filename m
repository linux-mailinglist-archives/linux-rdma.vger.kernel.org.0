Return-Path: <linux-rdma+bounces-660-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A008832982
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jan 2024 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D475EB241CA
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jan 2024 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C551018;
	Fri, 19 Jan 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/t7BSWi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20952AD19
	for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705667474; cv=none; b=FENjPgIrklMqkduS2sJCKR1Y+QWU1yg+xRWyj8VMnZKAnIyrhErK1LSvlbIZQKVZN1Y4jd3sDMmTpfZI+JkT0vwbG7Mqy4A19pLpJ8VuvdOt8BeK9MFKiOMWLy54hjDc9FXMLOfHmp/xXaH1+n3WO6OJGhg/DG283LGcyU2H7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705667474; c=relaxed/simple;
	bh=LAIVOhbdNt5kAUqdPjh6vzWH+xniHGk1SZyee1zXpS4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EYX+UY1AFMWfJfxKkffDsu7YoWPJ6H1hSaT07LDuAZ8/hE2XvttLoMIvxk49X+YvVvJ2d8pdhP7bx0ntIf0NoLrN3r0fuKvDDh7xy47Ni/UmauqPhRcq7ALp+JrE8j7cP/Vi/kk3aP8JjSnEfYJqFBj/FulgcXVh5lhVcRARtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/t7BSWi; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce99e1d807so101881a12.1
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jan 2024 04:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705667472; x=1706272272; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G10nrf5y+MkW7PU6HiC2/4WbNIGmOoFQuNHa7OgDDi4=;
        b=B/t7BSWi98dqgkEl9teFpzC0bJNMyyJZsuJP4nL0wGtY5PwvX802LW00uU1SZZp1d7
         MaxA2MW2QxJbHhA8OBP5zmqLnLIykPzzDoYWfVNL17kpJRA9FaDty9AeSpv5PjrGHtRX
         3h/V8x7noawTmlwtKmwj3m62LNV26ZQJha8J10kXDFzDj24DWGLagfYFenqFibFCeFqQ
         ApS/PomKpHSP6Y5NFgrTOdQX0QuhQbfUjQr4cT7L0iNkNpn2MOg1waMkiYzod3taWEfy
         XT86RuHGrfCCAOLh4d7n9LEJbLSH5dO9y7zLnVO+p3pBsiPExyG/M5CzQ8J/S6SKqtIg
         EvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705667472; x=1706272272;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G10nrf5y+MkW7PU6HiC2/4WbNIGmOoFQuNHa7OgDDi4=;
        b=hxR87xZU1uTTPCQHyScwcaSWGmHxvLV0BMZxaZ+W2xLDsrPzHyadwQJorh0J5Ob35i
         WSYznJFCB59RJrcg0vTPVq+0KXT/G61w1B6x5km8wYPL7y4me72KHqvy9ryN2psA78Y1
         MWPOFnzFIU7oyf5i/eB+Oly/CWFIAl9C4E6S2tKK4nhTvk4ur2QueMpE8koKH0kejvog
         bKJrZBRbiUGpnsp+b/Crq5+ITdv+fnaQXxoEkcoQs684PBNgt5R3j4ZmcPWV6r83kgXN
         XAeL9GkNozXwNPw9V0xc7GVn2s/gVicaKCjjuiR/lET+JcIgQF25IuvCoaZTyaLcZtXP
         FFlw==
X-Gm-Message-State: AOJu0Yy9E5wA0Pw21t6x59FQCkqEv+0uTdqISSvl5JM9soF9lg8dql7X
	MGBN99PPy13nUABxrgyGVy2ygjMROh4L2LuT33fNted2Ovs6j8dtkAvNZG5cvLwWrOlgyg4TjYA
	H0NrurxAfauoOLRAxt0wVrvBgndH7R5lAYwEq1A==
X-Google-Smtp-Source: AGHT+IFpqwnHmcrhut1EEYbhK8Jy/DsQydYb+hoFnAUbh1CHc/fkUuETZvSnJY3ao71Tx4YXWVhuFCedjmJhUE2tvqM=
X-Received: by 2002:a17:90b:4c4b:b0:28c:fe8c:aa93 with SMTP id
 np11-20020a17090b4c4b00b0028cfe8caa93mr4351780pjb.1.1705667472026; Fri, 19
 Jan 2024 04:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6ZmI6YC45Yeh?= <neverhook430@gmail.com>
Date: Fri, 19 Jan 2024 20:31:00 +0800
Message-ID: <CAAoLqsQ-iHo4YwsHyt6MkBKE20Ze=DF4kkFKkDX9QCDiDC2+oQ@mail.gmail.com>
Subject: Questions about RDMA subsystem shared mode for RoCE device with
 MLNX_OFED driver
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Questions:
1. Is RDMA shared mode supported for RoCE/iWARP devices? To be more
clearly, ibdev ant netdev required to be in the same net namespace or
not?
2. If the answer for first question is =E2=80=98YES=E2=80=99, but my test f=
ailed with
MLNX_OFED driver, it does check whether user can access the netdev of
the target gid attr, which means they(user and the netdev) should be
at the same namespace. Meanwhile the upstream code dose not have the
corresponding codes.


MLNX_OFED impl=EF=BC=8Cform mlnx-ofa_kernel-23.10=EF=BC=8Ccompared to the u=
pstream codes
---
@@ -1722,6 +1739,9 @@ static int ib_resolve_eth_dmac(struct ib_device *devi=
ce,
 {
        int ret =3D 0;

+       if (!rdma_check_gid_user_access(ah_attr->grh.sgid_attr))
+               return -ENODEV;
+
        if (rdma_is_multicast_addr((struct in6_addr *)ah_attr->grh.dgid.raw=
)) {
                if (ipv6_addr_v4mapped((struct in6_addr
*)ah_attr->grh.dgid.raw)) {
                        __be32 addr =3D 0;
---

Its definition:
---
/**
 * rdma_check_gid_user_access - Check if user process can access
 * this GID entry or not.
 * @attr: Pointer to GID entry attribute
 *
 * rdma_check_gid_user_access() returns true if user process can access
 * this GID attribute otherwise returns false. This API should be called
 * from the userspace process context.
 */
bool rdma_check_gid_user_access(const struct ib_gid_attr *attr)
{
bool allow;
/*
 * For IB and iWarp, there is no netdevice associate with GID entry,
 * For RoCE consider the netdevice's net ns to validate against the
 * calling process.
 */
rcu_read_lock();
if (!attr->ndev ||
    (attr->ndev &&
     net_eq(dev_net(attr->ndev), current->nsproxy->net_ns)))
allow =3D true;
else
allow =3D false;
rcu_read_unlock();
return allow;
}
---

I think rdma_check_gid_user_access should be ignored while RDMA
subsystem configured as shared mode, It should works with exclusive
mode. Am i missing anything? Please tell me the background about why
MLNX_OFED driver perform the check if anyone knows.

Thanks!

