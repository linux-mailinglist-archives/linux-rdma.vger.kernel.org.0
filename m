Return-Path: <linux-rdma+bounces-6014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C419CFFA7
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 16:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C3BB25ECC
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E46143748;
	Sat, 16 Nov 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0hYMQmg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504E54765
	for <linux-rdma@vger.kernel.org>; Sat, 16 Nov 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731771649; cv=none; b=p4TUykZpIWnamJ3aZzBzkMuFWutgfey4pv/bbjgK06Mheh2qQb6KGeOyG0itKSuCTueIOdx6lj6Aq0tvT53FotYvERM8ied6dyKDjf+m2pUVcSANP+vcObkv477Yz+l7fC6EO6q7W5jQNvL6eM5H5Zd0KVOKTWc6VAk7JItUPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731771649; c=relaxed/simple;
	bh=Wd+7kLQISUZlzyPvYmSUTVOb8NV4Vyd3OpsFXw6X7a0=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=Nhq44xGQtBktDIs/swkpdZuEGZYbiBtDXUjPdtbYnYbFLqlYGAl/sVAjJvQR+XrZS/kpe4NCtZ4wVeNv6C1viwKlnBJVVIb7GbAcYDRLxr195FzHXafMTAEYuNpEcDzFv+083keA3A3cE3y5pEkFkvtuPo6C42iV/H/w8SnJGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0hYMQmg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so592222a12.0
        for <linux-rdma@vger.kernel.org>; Sat, 16 Nov 2024 07:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731771647; x=1732376447; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=T0hYMQmg95iHtVuRfrsMasHvw2xmkp6k+SIOGzdwaym4N8fvSmdBgxIVyQwN/8F6Cs
         GxpTlBSlPdy/bC3OFqYuW2vdPKdZ9aZ7sPt18bbhwG7T/yawiTm5iIBn/FpajjPLkadi
         SpTfzLpvbbI5t5xyo379VMeAzTqlSRtL9KzVA4p745uNw/Muob2KHqBRtEYXWmkfVfII
         gkuxRE/RCJgwQ0EKovjnvyiZ+H+OhIDHkeDDU/HZZwYnS1U379ScMFqAcB326S7drdyb
         cvH2z/zwBtWbw3cQd/xHitB42/Y5+4NwIlcTKqx0Ahzn+csiaU5fe6/5ncuSo5OWgmkp
         K9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731771647; x=1732376447;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHEOkgJ64rwJ+cv0sVIqPUmbc8l+iTifR7HzGzNced0=;
        b=jGzDM9BZZC5xaaQ52ZOlqq7JN9qUE7WCyW/ObAfxdW0DSwx4Pn/Hc4Maa7+dr44jXZ
         SmHfMusY6e2IQTyvCUFLFoSA3voTzEKjBuEAR/Ol4xk1GN7CzXoSM2JF4CZ5/Jl8drzy
         Fdtt1MmL1thzezamFyo449WK7eZAF2xlvNVdpZAo2kTEbXqKDrR9uLmLip4HXMLl35dz
         ZrbDWmoV7tIvcmMXxQjQJOxH/yXGqOxAyT3CBfxPARS+RVqa+tXgbMKRnFq3EdpbBXFQ
         LbQYxdpD3aZpSWuJ6UTKy68aj/31yaTiyC1JOvQi1YZd1QE9p4AZOFBlgib8q3nykzOk
         mNtQ==
X-Gm-Message-State: AOJu0Yy5xL9kKFsDQxI5YWRW+RVF/cfSPAtUk7s9vobI3Mfvw+N1UyiX
	vP9aNKQban9SA23l+PcTVGMe98RWtmxIa9BKtlXOen77AuxgNy9o1vAXmA==
X-Google-Smtp-Source: AGHT+IHNxs+5Czg9cK5cKhT+ePuWoQ4brGzJM0M1vcBT/Qm6Y9s4Yw/8VA4mikgZgGROlJEspdgljA==
X-Received: by 2002:a05:6a21:32a8:b0:1d9:780f:f167 with SMTP id adf61e73a8af0-1dc90bb7d6amr9666032637.28.1731771647279;
        Sat, 16 Nov 2024 07:40:47 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c176a5sm3078344a12.3.2024.11.16.07.40.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2024 07:40:46 -0800 (PST)
From: "Van. HR" <kwenapitao5188@gmail.com>
X-Google-Original-From: "Van. HR" <infodesk@information.com>
Message-ID: <9d47eedb4397c10c284425a1e0f11ebba5c33c1bd4ccca12f274ec7d2fd4d589@mx.google.com>
Reply-To: dirofdptvancollin@gmail.com
To: linux-rdma@vger.kernel.org
Subject: Nov:16:24
Date: Sat, 16 Nov 2024 10:40:44 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,
I am a private investment consultant representing the interest of a multinational  conglomerate that wishes to place funds into a trust management portfolio.

Please indicate your interest for additional information.

Regards,

Van Collin.


