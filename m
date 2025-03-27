Return-Path: <linux-rdma+bounces-9001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17701A72BCA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ED43BB06D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E9620AF7E;
	Thu, 27 Mar 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XPLQW6kT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF564430
	for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743065442; cv=none; b=ue3b8xbwrLtFKRLH1zM1+Uax9OHPpA9y9sH9r8a/xCKmkYcawFiigCMO0GRJvBCfBhRXh4SjuzlWakSUqny7xYtES+x39QVC0Zy8wP2RU8+aISpmj+xhoOzmnWbmNpxKpnolMkr2Tj9slRHYxpIEJfQjIAAAvuGMgmWMfFaKY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743065442; c=relaxed/simple;
	bh=hnaFy6QUTu7t4xGVA97A8L2YWCy1soJEgfG+O8H9ecw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=H2GaXJsvPgj/y0LSrK3IW0Al/MkuewXhcV5/lwTi9MRXhQNoQ6CUhAbN01FxosLOdsirE9h/pdlWwgP/Y1QiBokW3X6nBR41OkPV+Z2R/FgL/xxXUIg0DxSATPqVTaKPe0x5kN5RmOzuxN5f+tLsGfph5nCbpVVJFN7YeRy5zRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XPLQW6kT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a27cade7-c8a7-4432-9b95-ad545cbcc468@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743065431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hnaFy6QUTu7t4xGVA97A8L2YWCy1soJEgfG+O8H9ecw=;
	b=XPLQW6kTZsDy7djcLCJE6SaHe6VThHtZ+pWeiZ8R0jyNe1bP0usgPl4Fr865lI5mEDiKOU
	fR8ISYRrDY1O3fB5S8Ff253RGwMErAs2e5w/jWOOMsQ6cALRpTCayaU42Po1vGvbPI4bai
	ZNedTGwzwSeehe4UXXzPRNhL7Smwlqk=
Date: Thu, 27 Mar 2025 09:50:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To: linux-rdma <linux-rdma@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: windriver company
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

19th Floor, Hyundai Motor Tower
No. 38 Xiaoyun Road
Chaoyang District, Beijing 100027, China
Sales Inquiries: +86-10-8477-7151
Tel.: +86-10-8477-7100

