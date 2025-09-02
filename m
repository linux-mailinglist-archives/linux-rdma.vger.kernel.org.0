Return-Path: <linux-rdma+bounces-13024-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAFFB3F27E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 04:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC185189E535
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 02:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911CC2DECD3;
	Tue,  2 Sep 2025 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dmpf6e0y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA991D61B7
	for <linux-rdma@vger.kernel.org>; Tue,  2 Sep 2025 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780914; cv=none; b=SeT8DP+q0qNoarjCvLFTPhzKw+ym/o2Yt+5LWBtV1F6SIAGaBaaZt9VyEDoVHkEfnhbOgnJX21XUNyLCpQeGQVCYkveYYkTdELw7qQ2MW1eK9bUtvxqvEr35LfpwirOH4B4jC5me2+LDoYpezLpvDQAQxMQxnm9d5wZvgpa7uP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780914; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i+EW0t31+FqUpxqkh7q6YPYVyN0NJyNw6mI8yZwQpfglnid+42MZVp2dRKzkx9upRFZNXPyCcAd0v9asI/fIkIVx6XdUfWYsxGcbLW+tiZX9KimNoAax54Jh9PBAXXrhMj5Oo0DMfjaKAAvoRI8DFplMV6EMP03QTMc3Zjjs6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dmpf6e0y; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2489acda3bbso39294865ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 01 Sep 2025 19:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780912; x=1757385712;
        h=to:subject:message-id:date:from:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=g8AW7s7PL9PVE9N0WdoKJmvOqy6Ot7ShrpEUZpFXZh5QqZ/H5ZotADBLuReClKinNj
         LIWVaEiHHlxr/oYQxQfipyF0I2au6Z6/YgyaQc8DiuuxBg26uK4Ns6Ea8GHmNjgOE9qB
         D8SqR6uSkwLAKse3cncZjydvLeG18nmqym5EpnIdxYqepzJz+n3MFJltLCuqzLkSUPkj
         duiCagL2Dz746mBGCP4Vx2f9/b2lgM8Z3VDmQdK1LiBy6ZRv68Yww8g8gXDOZRNfZXCY
         PeeIXs7RGqSDGGy7zTqDSQa9rcFJ3oc3W1VX4Y0LJeBYZncVd1l8bHm9gAW9jQI777hv
         qE/Q==
X-Gm-Message-State: AOJu0YzvhPRotj2lsLLNytDpI2x61A9lLJ+ZC6oDH6hNAZe/aqBJs53A
	rQvTdusVCAQYMqmXQ7iAzw6RsSBF44bT/VGuH0jyam8Eumcg4pjv5AC+YoLlpoZHU6yCmJxcbkr
	Qstj4fEqGMv7gaMWLQOlaC91m/GH9JOkC0P3IrwgIyQ7ZQSBarXirBbNskSYkVCyGsJF+Xxc1FB
	xZ+/5851NV9LV+CBHDG/InGGt4wGGYpspwcj47m/JclcOHb+SLng9KM3ZzSD+LG5W+S0r1VGzWu
	QJCr8jmGsvkmfM=
X-Gm-Gg: ASbGncvT/yaD2X0R8xyiircyvONDQMUx7app6ReV4G7kwsAWFyD0ZUjVywmSE0PrH9i
	5OLNtSwdOwZiMZQ5VezUY3aHsBuqCNns0H/Cswrw5kIr2b6iOiaC58Ebt9yZ5gSiB5zgoUDIDQT
	REQW9RlErQptTmMiL6NCQyW9NJAfYxinDTsQs34OUhKH8a36NZz0UykpzeCMlj57sAYlSQsWEf3
	HSd239gYNgKtUH5g/RuBBYbDeTRaO4WNhmBemMXVMFNq7x0I5yb8Nd/2ikC7bEjHsLa1/BaGH6J
	1HFQrs/hhY4tirFJQyhFl1SOUhP1gAUuI4mMfscDFKYJMUqP4V7yi9kVA+tihVuuyE06obWZUPp
	dXRqi2NYylD+ybuIPVFIWtTenX2mlkpqJ2wXEHARCFwr9bt/NUUbT+B7dTXPx+iCvYRHwdejgog
	==
X-Google-Smtp-Source: AGHT+IH8HyX8PR0XE9u5XA8oRW1RFi4RVGw6OnKz6q+ySvdOzVS/kpWyD8mbyYXsi8U5g/BmvSBqq1Hm1hR6
X-Received: by 2002:a17:903:228b:b0:246:a16c:5699 with SMTP id d9443c01a7336-24944b3d697mr132399325ad.61.1756780911984;
        Mon, 01 Sep 2025 19:41:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4cd006da91sm812215a12.3.2025.09.01.19.41.51
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Sep 2025 19:41:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-327594fd627so4986285a91.3
        for <linux-rdma@vger.kernel.org>; Mon, 01 Sep 2025 19:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756780910; x=1757385710; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Dmpf6e0yI4368P7T/73kE068ErlCULAowqZ4XwGh+FF2k5nuFOf+wLdz5FSha2FmpG
         jX57vCHp6EfjdWsl4gk5OdZ0rJmcMAhnXBdumWJkeeWm6kE5P7uxtmfZN1b4vSIb6zmI
         2+v300fuuJBK74dBickfDBRd3XxaLlJkq3S+8=
X-Received: by 2002:a17:90b:4f85:b0:327:add2:4f31 with SMTP id 98e67ed59e1d1-328156e57d2mr13606365a91.33.1756780910018;
        Mon, 01 Sep 2025 19:41:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4f85:b0:327:add2:4f31 with SMTP id
 98e67ed59e1d1-328156e57d2mr13606342a91.33.1756780909577; Mon, 01 Sep 2025
 19:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Tue, 2 Sep 2025 08:11:37 +0530
X-Gm-Features: Ac12FXyP4JoAEama0XEk7qfjblCVlS-kP-vd0IxlvtRXpeJf6ZxQJZlc_T6MDUs
Message-ID: <CAMet4B6mDArM8me2hOZUJiNMr3DjuAHAmK9r5AXc17zNZdxNFw@mail.gmail.com>
Subject: subscribe
To: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



