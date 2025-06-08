Return-Path: <linux-rdma+bounces-11061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D310AD11D0
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 12:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ED8188C373
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Jun 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8320E32B;
	Sun,  8 Jun 2025 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i02e8sQt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887651D9A54
	for <linux-rdma@vger.kernel.org>; Sun,  8 Jun 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749378491; cv=none; b=qCjUYG83/hx6Urqmw8pOoUDWdWNr68WHtgiuWrMOGLcc0VdBuV8xqQj2H33kn07Domq3d42DJYflk/AQryw5FnVRc+wectd/PpZGszbUSxh4dMjsLDlP5KNnfLJQdTGNThaHHz46bFuzQ55mZvDrvOYRDD8I0M+uhYSexf6T3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749378491; c=relaxed/simple;
	bh=5XmXYyPP+Qgj3KAzI5TCizU+1tR97vPgTh7ogxJMr9Y=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=o3RRqDCcj8zjTsMMCpHi2X8VXw5aSBagw7DX0t1aU+GTAaxTApcFJYS8EPYJZK3Ip5l17sIi35+d/XcQmqDMtkuXlDJy65OFyPiM+OmLGO9/hoDkfd/BjGDAp+G+Cssr3D/3sgS4pxxXfj+OHWB5hF7V57x1TfcGgCl8kFotlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i02e8sQt; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749378486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B/HT30XtNYPWprYJg7+tfUoLJlqF4TDkJ7I/aq5zsBk=;
	b=i02e8sQtj/TAeha5PdFa2AzTnpxrjujmg5VC83CxtMJx/0YhoOVgGWd1EhcDIT7t+B+d7r
	NeD8ogw/I6kCq3hRaensONbJgYX6Uh9+EFS7dpJfvBQEyxyimLr+OrJrjv5f0xGgsrTqpJ
	vlDk723/imcUuK1R1vvsS6A1MEtE51w=
Date: Sun, 08 Jun 2025 10:28:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "zhenwei pi" <zhenwei.pi@linux.dev>
Message-ID: <f1cdcb41eb6939ccd12905391f473e74337c0391@linux.dev>
TLS-Required: No
Subject: Github RXE CI support
To: linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
X-Migadu-Flow: FLOW_OUT

Hi,

On July 2024, I attempted to contribute the new feature of Valkey Over RD=
MA to the Valkey community, which allows Valkey to communicate using RDMA=
 and achieved significant performance improvements and latency reductions=
. Valkey is a popular KV database with a large number of users, so releva=
nt CI testing is necessary. However, the virtual machine used by GitHub d=
oes not support RXE (compilation option is not turned on), so we need to =
compile an out of tree RXE driver in a timely manner and install it into =
CI's virtual machine, and then run the automated testing program. At that=
 time, in order to support this feature as soon as possible, I copied the=
 RXE code from Linux based on the kernel version of GitHub virtual machin=
e and successfully ran it. Later, with the upgrade of the GitHub virtual =
machine kernel version, it was also upgraded once.

Link of my RXE: https://github.com/pizhenwei/rxe.git
Github CI steps example(Valkey: https://github.com/valkey-io/valkey.git, =
CI config: .github/workflows/ci.yml):
    steps:
      - name: clone-rxe-kmod
        run: |
          mkdir -p tests/rdma/rxe
          git clone https://github.com/pizhenwei/rxe.git tests/rdma/rxe
          make -C tests/rdma/rxe
      - name: clear-kernel-log
        run: sudo dmesg -c > /dev/null
      - name: test
        run: sudo ./runtest-rdma --install-rxe

Because Github CI virtual machine does not allow to run 'insmod -f tests/=
rdma/rxe/rdma_rxe.ko' directly, it's installed by 'sudo ./runtest-rdma --=
install-rxe'.=20

With=20the increasing popularity of RDMA, more and more services may requ=
ire automated testing based on RXE. I hope to have community support for =
the corresponding official version, rather than using multiple personally=
 supported versions(like my RXE).

Looking forward to the response from the RXE community!

