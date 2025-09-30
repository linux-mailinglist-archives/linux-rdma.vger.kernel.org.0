Return-Path: <linux-rdma+bounces-13737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724ABAE30B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9FF170CCB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95E830C0E9;
	Tue, 30 Sep 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TuBEgx26"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37082472A8;
	Tue, 30 Sep 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253432; cv=none; b=aifWdA50v/Tzq1/n8d+hRgRjcKp9rRFTn6wkCcZF7gkiv4ULm7++LV9IA0umoJzt2SiUGAXoPKshtPzyrMLDnINpio5MwCiVcT6co98BYyRRsWQglgg6OYp6MsWIkaSp1511lFXD7aeK3PCAG5Bn/snZ5mN3bDnnXhNFAZRpbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253432; c=relaxed/simple;
	bh=pLWRomEWHMCJJcdA7B/x76jaKO31uCQkaUkcIDrKzWI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TiB4F5o1LmMwkMjYl+Nb2ex1ohWB6CBkDDsU1AtMKHzoagX5f3QS8y5hrgtfg/WXvBYOXL/Ww6yCzNe3t+dsU2cwinhSay1R0rQuG+4suLGmIStrzEgs2JKgH528Q/kcCL8DkFpxD8JigZkUdWownIGh5+cbmkPwqPg6v2Fieyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TuBEgx26; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759253427; x=1759858227; i=markus.elfring@web.de;
	bh=FhWGIbww3II4LIlmLX1DcGogc+sctvfoZlXhRs+moug=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TuBEgx26/6EbiczAI8Q9U5iItCtAlBbX3mxZ2K1Hw0WNLEhujBUTpg8Nbw/FfU7k
	 U91z5UNEeOtH/JX2vCaNRVewJ6QgB3/tynmBR5CGshF8ncXJ195XdWsa29RibGKjl
	 PQP68cvlDJK3LXEavQ1TFzIb6MZ/+QLMZQPRCMMeIEEGUmUYr3f1PkOVdsOjM69c0
	 lcLIpAuxq/cD87LnsetvPt9yND8Xrvy+nE0/oUMOPVLyl2nluOJ9G3mtwW4INmVO0
	 V0lvke3Xv05cqKuXI/YCduyfJzVXpkub8ZDF4JBTo1Xlh9FcEg72+WYSkSStIVITa
	 qrdT20zdzKbKH6MCmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1u9lmB2dkS-00tT5h; Tue, 30
 Sep 2025 19:30:27 +0200
Message-ID: <d5d3df5c-3cbf-403c-ad89-aa039ed85579@web.de>
Date: Tue, 30 Sep 2025 19:30:20 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/6] Coccinelle: ptr_err_to_pe: Adjustments for SmPL code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ifg0K8XLz2kD1r2OLZz3SGGJ2z264BN76aRcY4vNzm8Pnk5phy1
 6L/QMQtsFMTXfyZkw5KJ8dFSe1tkJkFZ1pWJxIihvO+ZRjz4exAJl62XPZFVWeYw7bNXCRp
 UnAZYinXcA930JrydyNsFBqZDIQ9yVB7PeimBLhYCr6jhCm2oRYoNgeeTTtlgsPhNT068+J
 R8/8znSCLXn604vSB5gng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F+osHgO2r8U=;3sAQa9EyhjFsKr5IWyXkmnMsgE9
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 30 Sep 2025 19:19:38 +0200

Refine some implementation details for further development considerations.

Markus Elfring (6):
  Omit an URL comment line
  Reduce repetition of the key word =E2=80=9Cvirtual=E2=80=9D
  Restrict the metavariable type =E2=80=9Cconstant=E2=80=9D for the usage =
of string literals
  Omit a redundant space character
  Simplify two SmPL dependency specifications
  Distinguish implementation details better for operation mode properties

 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

=2D-=20
2.51.0


