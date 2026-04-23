Return-Path: <linux-rdma+bounces-19490-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFYBHa/S6Wm9kgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19490-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 10:05:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3544E4B9
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 10:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F45308B5BE
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415313630A0;
	Thu, 23 Apr 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npm4m/63"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C787B36309C
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931262; cv=pass; b=r8B5Uvbt2iesHUCfo9ZQF1HTQuG/AZFodD2ZEeFfLYDb/i1mJf+xmp6iwS+HNJreP9JjwzSh3ZS3Bx4QdPZX2lU8HiMyre1/FVXqiJE/t1hmtKwUPu7VC/0Hn6KXXzpNfBaLmeK9z6bcf8u/74j/XWnbbS8leDUyT7UeHOxWD+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931262; c=relaxed/simple;
	bh=oV+qRGBoOguFntB3gQt83gXw2H1PXenjp6DBJv+PwnY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CiqkbeW7JyAQcG3ghp32dLe5/1hyBRG6/rpnxZZHgV7p/Gga0ZgKQVays/PxK243k7JHsJqnZX0on2TP+4Z2XKg/FICUCHmOtNPFozgvCZmNrFmVJdurWZkpViENyLA+t4OQFDFZN0Zfefc/yGe3sBkJlEA7/lnqxCWsmW3dUyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npm4m/63; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7982c3b7dfcso59017267b3.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 01:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776931260; cv=none;
        d=google.com; s=arc-20240605;
        b=Wi9+MD44Davd+ojwmvJnQU4ZQMunVjDQvV8wa3m9yCs3GwYHUcpOelFKcU5fJqdcjr
         dZF03fPD0H3Zf5VYVhDr8AOgANBF8TnQWoWbafO/7Z5eILuCQOyonngiq8k0Abkkoqt2
         9ccxTiI25fGDmhw6ZWBppSZDSv8PgbJDLCQoyFSzLidKThmQyMoEwnuB5f9/1TacSiqC
         SOVtzf8uX0n8druZan2dE69REFK4aRrH14b7BlDKOMlthqGDOAJy4VFo9EDcxlxzKMOi
         HmFOo03r1eeIAFgoGw7UvHq46jcR9hiUmKHazbcbqHinQCHhjofdDKpNV41br+yybXpt
         6ZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=foidsqa8Olw1KsuUlxfrgdXZyCf9RpiewIo9G3B1QpY=;
        fh=113rvmz9xXU7ASTwBko+26DhPJN6YSjZ6/HSSlkXcr0=;
        b=YNSydAql1Gnz7svDMidcMqidfAjXn6W0w5P8kbooKNPxM5jvksVZX6gEsnVYBGjojc
         qOfpN2sQwI6uHzK70Yr41c67pAVy0a4Cyq4guIJAxs/pt3ciqqIeI7qPfc/QFBPZ1ei1
         jmAnAUqznBrxKxLXC5vIO8rQbt/kq7o+kgYji3Kzhs5c4UNDDHK8iy6pzU1OI/eXmI8l
         hE6UcVu4jR1MRneHZJbVExqckfbKMjgAKTEUF+yaersfOt403QA9vrsTQYwN2h0cAE71
         +NmMmyuCetRAqx3hSoyt+mEUPYKBeKpiAj/Yc+/D2io+dxYASe0tOaFigPJAAh8oW6Qt
         Q0dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776931260; x=1777536060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foidsqa8Olw1KsuUlxfrgdXZyCf9RpiewIo9G3B1QpY=;
        b=npm4m/63uTCwDd20xBQd9nCXj1JRN36cbk4JhsMjEVroMfrOg7cbw+gU6600pMz/ID
         Ec0Ga67yR9DhqvF9h8YuGZ8nYOiweHDSjrUuwR/oWn38qq2vUwOC+mAXcae4HFYxB50u
         LsxlvwMsayUrQ+CSDp1j5Ci663fG0Ckj4h/UKyMDt6blmPCbEw8hLbjCq0Hp6iCdQOr+
         ojqyBG5fHJI3vOqJWFB5sMQFbupH/L5IYR4Dn/Z9zMRN5FKu2v4ZhxYJ0eBbzKVKvtND
         kxGoqQiD/gCnqNwzLyKHoYQmiuzwIOA8eORmqd21Ghyb5Owi1b2gcwJpWWmK3gAwUfAo
         xGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931260; x=1777536060;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foidsqa8Olw1KsuUlxfrgdXZyCf9RpiewIo9G3B1QpY=;
        b=Jr+UyQIcNCXly7LcZeI2QW28gTunlpfiEK/+fOzm3q5Usl3PGIc9w2c7Yk4MQBVg8L
         BTFqm3haXPquLgbYyDzIUXxeqJEVwYkUGBIFGN9bthwPYPXQwecwK8LsfSfzBT+iUdwu
         6N1OaHFW5p0NNVZP4WJJJgCnP+xHq25M/NVZXuHPyxMLjHm0BmP87mmG1/snMy5PDdF4
         /vkiV6Vb2arLC5aQOwrmHnMSPmEzPe3R0a27inNuwhNUfPlmnIo9tF13PKLLj4OQ2UdY
         Bb58OE/+Sr+BMJarIUbdwfu2MXX+t7IEO/Pg6k0KkkDKfsE1bcwuZKQe/bEDQ+jY1KbS
         1wTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Kt1cS/agaLpMfvnkt365wYCJiB17XrfRiM6LkZFRHRWnOSYHCyHQLx4zW9X7jgNUzw5x20BolzOul@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AtM+fOJYFsSWCDMsVBfvSD0A8g/KmQqYy1uiL+OomfFnDgLd
	Yd+ycPnTOtJgApRTg1FwAaMYjqbomgJw9f9sZyadTEVwzENMzMMaW+NM+Z9uo42FlTOX8mmZn6j
	lnDM1+W3VnoBS4Mi7fWjoc9sNJ3UxIYY=
X-Gm-Gg: AeBDietvfm0E9HZDp8YHt3hg7bSfNtofxBJ7p0gWM1eWVAKVaPe+m7ONET7DDv6N74G
	ww2WjO3pIv6pa5sF2UBuCEYqoD4ZxM77ID3MwgOAvtG7KNleccS0wzSMqFiwlz47crQczPhjwrN
	ZdISGcAo1KUi6aLzY8WxEqQWDmOSYYHrb/Ss0XQdlX7PGn+IJ/2/eHU3vutCG5O1Lg4JByQAMMq
	SISy7M3yMAGzmmANz50opYZ/+UXtyjhWqQn6MjQ5/okzTuuo2MsaTblm/EbUwEqmFI3MChF5rfm
	TAbzov7jdMpWxJ1RTDaHpNBrSXulgNQ=
X-Received: by 2002:a05:690c:385:b0:7b2:136d:240a with SMTP id
 00721157ae682-7b9ece5aac0mr252351357b3.9.1776931259677; Thu, 23 Apr 2026
 01:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Thu, 23 Apr 2026 16:00:50 +0800
X-Gm-Features: AQROBzAvsqNdWL8c7JxoMrUuUFDjBJrCLgdZwcoJLGOGcJKSspjOch6mGaahHfE
Message-ID: <CAGp+u1Zt7xjm9H=sY_BDV1z9-J5WaUZCcMb8KB5h_8eE55H5pQ@mail.gmail.com>
Subject: [bug report] Potential refcounting issues in 'drivers/net/ethernet/mellanox/mlx4/srq.c',
 between 'mlx4_srq_event()' and 'mlx4_srq_free()'
To: tariqt@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19490-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EE3544E4B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Linux kernel maintainers,

My research-based static analyzer found a potential atomicity bug
within the 'drivers/net/ethernet/mellanox/mlx4' subsystem, more
specifically, in 'drivers/net/ethernet/mellanox/mlx4/srq.c'.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
mlx4_srq_free
     --> spin_lock_irq(&srq_table->lock);
     --> radix_tree_delete(&srq_table->tree, srq->srqn);
     --> spin_unlock_irq(&srq_table->lock);
     --> if (refcount_dec_and_test(&srq->refcount))

T1:
mlx4_srq_event
    --> rcu_read_lock();
    --> srq = radix_tree_lookup(&srq_table->tree, srqn &
(dev->caps.num_srqs - 1));
    --> rcu_read_unlock();
    --> refcount_inc(&srq->refcount);
    --> if (refcount_dec_and_test(&srq->refcount))

In T1, the refcounting increment on 'srq->refcount' does not check
whether this value has already reached zero in T0. In that case, if
the refcount already reaches zero, then the first 'refcount_inc()'
will increment it to one and the subsequent 'if
(refcount_dec_and_test(&srq->refcount))' will test to true, resulting
an additional call to 'complete(&srq->free)'.
This is potentially problematic for mlx4 NICs.

Thank you for your time and consideration.

Best regards,
Ginger

