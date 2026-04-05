Return-Path: <linux-rdma+bounces-19007-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHfhG7vd0mmAbwcAu9opvQ
	(envelope-from <linux-rdma+bounces-19007-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 00:10:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA039FF38
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 00:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6ADE93001FD1
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005663822AF;
	Sun,  5 Apr 2026 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHMIQ5EK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238C1A262D
	for <linux-rdma@vger.kernel.org>; Sun,  5 Apr 2026 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775426998; cv=none; b=ODA005ieuOdmGnmGz9YhUvyhNT1eHrhXKCGI1lczz4/3cC7ZUXFv3b+8q+3JlG9piPjiWukTKFe6x+JovzG6fBXwfCG/r+EpHFCIOnz6UGEBTkhar9BHqCTJa8/+HYfYGtte3cm5pEZ0EzcLHkiXmjZLENGYidIPiZMqQWsKKZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775426998; c=relaxed/simple;
	bh=8Q9zPy/eVYWg6U2VHq2Pqsr1nLFAdvDOocq4kyym9tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+a8pNcCLU8DksxOJ3RG/4mkwHgqpYk3Bl/FGORO1STziNwS3IyNqOsi/on/jGqppg3Z7gK7BXsKPjHv6VHxLm1oHlFzpbBkqKG1QagcvaKPlmwOShJjrWcQnvn/9aUm7+R0ZgV4y2tCQxFDCpyAVPMT8sIDC5hRKYFnKHriV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHMIQ5EK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so1786409f8f.3
        for <linux-rdma@vger.kernel.org>; Sun, 05 Apr 2026 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775426996; x=1776031796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Q9zPy/eVYWg6U2VHq2Pqsr1nLFAdvDOocq4kyym9tQ=;
        b=fHMIQ5EKjK0baclLWqdtWtuZJc0dmyIgIxqWuOBeu1P6l8koxYIDCpsfjbOr24alAu
         ujvaRjF172bOsmiBC2lpsAbl11py30TSyf8iOYxsPKpBHXudBRMwau9q8nelOq+XP7H5
         uNJ5UVcnXMdFsUY3JKZlrpk6Qu7IWDGpN3hvyO8+x3I9y9wArAttgBldTEd6k+ibZGip
         WRw63PzqOHCMPoO2Pe0fCZUTposK0DN0HZGH5/yF4d+qI7HZteOnk/VjBmR9f4y6IqTQ
         nklxD0oh40KqXVy/C0VdXD+NgmSJeF0k8Q++YtZOBpaPoP0kTHDN9S2RDolKbzn50Y8r
         Q60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775426996; x=1776031796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Q9zPy/eVYWg6U2VHq2Pqsr1nLFAdvDOocq4kyym9tQ=;
        b=Y8cpBO9wrqLhBtQyUd5Sd5ZvEeHipF2P5sKYG48r7bYjR2PQD/TAq1sjUzXYYDw7hn
         bsLa+2LaJnCeEo8tUb6tyML/4IHomP3rA5tqBMXNohqSJpJhL+tHfUiYE9SRXFjHEYyh
         kxG3kUCDornIhhjtZAgmfX8FrQ9/apq0xHOgb73OlHE9knl/3IombLU2TPkdMU7Jmpqn
         1tE16NqOecpyI1/P4PUYASxXcC3lBngEtxaFZ/YdkMILK6cto5a+0zF6u8JjUHeldvjj
         UzNQv7r1+Z+yTAOw7gYj4S6hgIHzMNQPA8zrJ1obxy5hkTh4j9vY4gRI/goTSG/z1VDw
         4X/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFFHmBLq4Ml1LMkt6YyIgFfw8p56RQxGrtx2HEQ0tSnMrFfybC9h4lGCWh5eOgpBeI0BmuYckczvCN@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHfyZAnMfrkBTSnBK/Me8PMcH3+SiNk0ym2Nw/DRkBNw9L3HA
	IwnAf4dijSOoPlmLMx8KBsqfJSV2hHPSIbwEW+C8kxNIqYz7TmS20ozLx2+nX4O9
X-Gm-Gg: AeBDietFgu1V7K7+o+TlnZH/TEibLE6FA2pTKjOUb/qmUuzHrdBe12F+oO5P9oovYwq
	hKVEf6YzLQ/aQgvlyMp8ztJJlpMLnq8aYGUFHoQ+qrKNSwhW7bufRx0brjsXxOyTYPaTKKFQxDM
	kChtzWsSZ+WI1XfvobJO5dFtJYuv3FK2HDUxSGa5v6YYtfj59ZDMMzjwYdtIS9RPhdjP5P4s6IU
	kuReUzleJe9EwfIgYWe8HKgI+xxg+xehOmqNjbPDf3udmupcN/OvWxwoOu+ThrBUzWrUzdS362b
	oUK+0RkTK9MnLTSVrp6gVKQotG3p3KWbd/8mIS04FSGDqloBhYa2AXMEwdktm1Ofi9z930Oamdh
	LQY/2bMgRb8KxRP04kjZVfmGOiKbzTt1GPm5wX7ZKF77sPqdacdkix7rY8HKw11uoCsHVRYOWKa
	iNMcbYrUio9sTrKCBlisORavBT0rR190DucIrq/uBy7sdofmN/56+p3zhW1DGRxDXkQktG1hIu/
	FCBf2zhCPmKZx8yImHu5/1OPvFNkZDBvaFJKDTnytTtNanp
X-Received: by 2002:a05:6000:420c:b0:43d:1c7a:8b5b with SMTP id ffacd0b85a97d-43d292f521emr15058073f8f.40.1775426995841;
        Sun, 05 Apr 2026 15:09:55 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm36050541f8f.3.2026.04.05.15.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 15:09:55 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: leon@kernel.org
Cc: dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	prathameshdeshpande7@gmail.com
Subject: Re: [PATCH v7 0/2] Fix loopback leaks and return paths
Date: Sun,  5 Apr 2026 23:09:54 +0100
Message-ID: <20260405220954.19412-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405192244.GD86584@unreal>
References: <20260405192244.GD86584@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-19007-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,mellanox.com,ziepe.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10FA039FF38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Leon,

My apologies for the noise. I have resubmitted the series as a fresh v8 thread
as requested.

Thanks,
Prathamesh

