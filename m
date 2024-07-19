Return-Path: <linux-rdma+bounces-3908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF5937B33
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 18:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9892831BE
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jul 2024 16:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D369146A66;
	Fri, 19 Jul 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co4MzmmJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32914659C;
	Fri, 19 Jul 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407364; cv=none; b=Dehgwq8M+pO0O6NaDa6zKu8USc61L5nzuF9PI9shcuRzbGJY3wjpvg+9jIqwnmu0pVOs5+ISPx7RxqneL/napQ4rUrHQ5qMUqyEIW6/fDxvGoqZoWlmcWNg4nXLq0+BuIubQDx4/WaHkQVaNMayxK3EkbhsGa6Ku3oH1oiET5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407364; c=relaxed/simple;
	bh=QfagxJqgu9v3q3yZPMtMTkcw3Yd3mQN2sYTMlgnGRVg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ULmbNnglpSFsW+pKubKbJbWBgCjxSzneyaFtBbXbyn7zS5rDEBz8c9X0iNUgrG/wUCYOasv0+3uzS2svMmGFdL+NX0YYdSWrYTpu5SjGkiyv/4x/YbZgpYBxboZ8P2tHrZQusvrblWmT6Vq2KEtjjKQoKoCxqQxCElSywupKP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co4MzmmJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447e57103d5so7986651cf.2;
        Fri, 19 Jul 2024 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721407361; x=1722012161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QfagxJqgu9v3q3yZPMtMTkcw3Yd3mQN2sYTMlgnGRVg=;
        b=co4MzmmJqdatcIJqPebsVUGJWdDPJ/cqhceYp83LWzRPdndujwjQwOCeEIEeLG+sk5
         s0th1HerhtK1IYV3iFosfO5lu3zdhr2UNT+sORCq4MR6eu7EJy4BfgNBv5ELl6UnzbVc
         yb1u+i2uPMNy9HV7djKmUWS2xjwfSXovXZTc0qZe4KvyI3eZO2OGx5v34GD2DVIfDCoe
         CTaECq5UAokduitESpENFO1EKyhs95CQz/uSdrqroS99BtjwySCXr+ozx4SorgdtO7ZK
         xmPLFa/b4XV/+wvIZx2jCzu4qMnaFaPJQnArasv4nY5qM9AMuHTzehkc8l+YZ14ry75y
         hnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721407361; x=1722012161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfagxJqgu9v3q3yZPMtMTkcw3Yd3mQN2sYTMlgnGRVg=;
        b=TNt5lteo6li50/qQhgLicTCLb6lBuqCn/UCDK+cbyi/6lgnPa+nqBB8U7YmaQ1aUFU
         nfsHztGh8WKj5fYGmg2lZEmmyA39eoy9nj5Uk7Unq72kdUMi8z+OCny8XDLktSC7bAsq
         gs04uuKsBn8LL8dInR9EOh+6xBgRSAk2Nk6KbWa+tl9XWSBvaal2beCR1pwJuS2PL0Bq
         gf+qzkVBEKGPcPMTw49tqNNuU4e7WyaGjvV/K5Z7UtbsAgVxjkqXOcs7jflP7f6WTtQW
         7M5e/2C5NrDanutlc586lnJ5QmDeppHWRAp/86YaJQA13aUvENtMV/JNvls//svRHmcm
         lYyg==
X-Forwarded-Encrypted: i=1; AJvYcCUyJtMecIyT4kFK1eQ5pBuiWj2ZsgFRvtbZ4nPQfJPqhZKnvw4bqI18dSGVzW9EqIphh//C69nCHzEdqGFphGgfCQfouD4FwsF6RQ==
X-Gm-Message-State: AOJu0YyfGkWfhmuiIZXaEyfaIpNNZXZAzKuXrabWeDvKQEmXctnXKf8E
	/rDF1ALkxBiHmDLtEEzGYzXfw2J0r+dOM2MZZbrExdRJDb8Oau9psQyt9yvPMPRWPGXkRu5lSUJ
	6kh6xxWnXtLnTpa6PpbbvdIzHDXGH4fTDDKk=
X-Google-Smtp-Source: AGHT+IGxZtt3W4QSf401Fq0IThR/y7HH8bHjBVF3/bMGtMpF9P6ywv4iujXJ2pMJgFV/4A3mxoNdUi0/oMFWilfj+ks=
X-Received: by 2002:a05:622a:650:b0:43e:717:38cc with SMTP id
 d75a77b69052e-44fa535fd10mr5035821cf.53.1721407361250; Fri, 19 Jul 2024
 09:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jonas Rudloff <jonas.t.rudloff@gmail.com>
Date: Fri, 19 Jul 2024 18:42:05 +0200
Message-ID: <CAJQ=pJzpksfdLPEz9jbFOYCRn4AfJmmM-WqLhteiGNG-rfTTsg@mail.gmail.com>
Subject: ConnectX/iRISC research
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, 
	linux-rdma@vger.kernel.org, tethys.svensson@gmail.com, 
	=?UTF-8?Q?Kristoffer_Aalund_S=C3=B8holm?= <k.soeholm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We are a small hacker group from Denmark.
We have during the last 1/2 year been reverse engineering the iRISC
architecture used on the NVIDIA/Mellanox ConnectX NICs.
We have given a presentation on the subject at the hacker camp
Bornhack in Denmark and made our research public.

We are writing to you because multiple attendees have suggested we contact =
you.

The research we have done is available here:

Git repos: https://github.com/irisc-research-syndicate
Slides: https://github.com/irisc-research-syndicate/documentation/blob/mast=
er/NVIDIA_Mellanox%20ConnectX-5(Bornhack%202024).pdf
Video of the talk might become available here at some point after the
camp: https://media.ccc.de/b/conferences/bornhack

To the NVIDIA/Mellanox people:
Is there any way that we can get access to documentation(or even
source code) related to iRISC or ConnectX?
We currently have no idea about the impact of what we have published
today, and what bugs or vulnerabilities people(us or others) are able
to get from the resear
ch we have done.
Are you interested in collaborating in further vulnerability research?

/Jonas Rudloff, Tethys Svensson, Kristoffer S=C3=B8holm

