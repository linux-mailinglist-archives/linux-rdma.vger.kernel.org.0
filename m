Return-Path: <linux-rdma+bounces-13925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EF8BE8BD9
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A888C561D18
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DB9345759;
	Fri, 17 Oct 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="X5mG0Mre"
X-Original-To: linux-rdma@vger.kernel.org
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62710343D64
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706312; cv=none; b=mCdgKBOebS8Wh96hzLeTg5U7suSxBf0fXR3GMGq6JububCl0WNm28cYLwytHrcV09nVmOY7++zJ3zuQtHgdgu3NN4QDLwMfvYmQ1Ua8lM8JKiDH/dcXRAgfeK0US9o5igDrxR5uqE+1MTGgfz6DSWt/hdEPRfvQ79KdaJX7tjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706312; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=deWkFjpOwUl9ti/hf0VDaT80x1T1mi0+fM0lxOjKXXtfvJlEkhr74VYWsva3xOUjeK6pMeamlJ8tHEENANo8tAPiWTcpAl+i1jaRJKf9oVziv10kXBVB9xnu7L9LpIML/y1z5mhOiGD6WmLkxrmoEZWok+0d0K/rgX8DAhs8EL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=X5mG0Mre reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id AE1C34A7793B
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 07:45:34 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705135; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=X5mG0MrebGlINQJcyjnioaRxK+eDv/HoUf6MsHDltXW9bWd436yiKujRvFopWdQXuBeh+c
	+8t0EOtO3A4VNLsAw5DCdld+qt3QTTyzvJFD3g8Co+AaoiDfxkR0fWvhAZm3US+Tjid6+K
	wj80BtIAPge8snltZVGb0hEatiGOrh13UgyVU4VqHCx6UFHjZL3X+CJ7fZlbKuTCUBFOKV
	UkkcOsCs/HBENAI4MOMS+fq53OIbwb77fb+5CqwicnEwvKyD8VrJQhew2BNIZa0kpfT+ZB
	Q8nocLPH5jHmdIBLhxhtJ+e1GzttX0jcmF8IJjMZ9unWbHBupWhEnNk2s2dqIg==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-rdma@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:34 -0700
Message-ID: <20251017054534.E2799D500C91F0F4@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

