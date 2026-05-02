Return-Path: <linux-rdma+bounces-19849-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO8UHHbF9Wk5OwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19849-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 11:35:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAB4B18AE
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 11:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942483016CA0
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A430FC21;
	Sat,  2 May 2026 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J45eh6Jr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65E30EF97;
	Sat,  2 May 2026 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777714542; cv=none; b=HlGZJdle4dJmL1Fchtx8jnBe+Hj4enBVQFpsL95ME5jXmPp74Sjuhax1V3z07xGyDdYpmbGrUd2F0Ts7UY6guEvHlf+w1fNOBCXCqOmA5mvCJvq95PSAmS7U//13ONeiNjRXAuFHNgSBCcq040kaf66akgNTPwj+83Jtj98cjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777714542; c=relaxed/simple;
	bh=Wz4Q/hX6nmO+cFQ0TpRkx6Ettzn+NjVNA6GnTV0eqew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mocMbyztq0VMxMIru6nCCVECZYVpIgfCDTkPJozeU7pNgeEIGwBEFiKfzZ4gaMxuuI1YH9C6LWAY9pbnVOQiquuMQX3/FvHoqDUtYJ0XzT5deh15AW0CcO9XpFzaF9limPg5V/0ApKm8DDdyjzxaNL6b+o9cSE4EwPg9j139TxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=J45eh6Jr; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g72nz4pppz9tyJ;
	Sat,  2 May 2026 11:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777714535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YD62FYaG+7ooT7sr2cKJAZ5DvdUXH1HM8sfBS4QoUA8=;
	b=J45eh6JrrVZdlBu3Wzaiadrr68NgOmaw5yCqFwlRVC4cddiPzQtt631SBsDWhIFUGvkydH
	1jYIp3FdjNHV/G4D3dB7nbkRu6VpkUUqnd8vCVb+yGpxpINj/3k731k2sCBMZLZmCeEZtk
	G9pDmSPvPf9nby1A8W77Jcgz+v65v7odnkXVEU5eGBa/q/1m0X0W9v9gOreJnYilpijO3B
	R+CG2yCVmOgJLqNcONBrll71la4685hmnMcjK8Ajat1x44witE4AXIMLsaAg8sF5CkjugI
	aMXLhdV5DPdgqKYRN5UvLkSP7Cito6CyHHJoMHYRHC/W+O4uz6LLfydo/SoWnw==
Message-ID: <a43eea6c80e60351102cd722252b963a1eb7f013.camel@mailbox.org>
Subject: Re: [PATCH 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
From: Manuel Ebner <manuelebner@mailbox.org>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
 David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, Leon Romanovsky
 <leon@kernel.org>,  linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,  Shuah Khan
 <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Date: Sat, 02 May 2026 11:35:29 +0200
In-Reply-To: <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References: <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: uaweiay3waw59qou6hnfz4oty9y3zsb3
X-MBO-RS-ID: cbc3c8409f818b73279
X-Rspamd-Queue-Id: 1DCAB4B18AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19849-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Jason,

i've gone through your patch, just some minor and some optional things.

On Thu, 2026-04-30 at 21:08 -0300, Jason Gunthorpe wrote:

> [...]
> diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
> b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
> new file mode 100644
> index 00000000000000..0ab941bad7a66c
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
> @@ -0,0 +1,1406 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * mlx5 VFIO selftest driver
> + *
> + * Programs mlx5 ConnectX VFs and PFs through the bare-metal command
> interface
> + * and RDMA Write self-loopback to perform DMA.=C2=A0 Implements

Write -> write
else it feels like there is a new sentence=20

> + * (probe/init/remove) and plugs into the VFIO selftest framework.
> + */
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <time.h>
> +#include <sched.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/pci_regs.h>

sort =C3=A1lphabetically:=20

+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>~
+#include <string.h>
+#include <time.h>
+#include <unistd.h>

+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/pci_regs.h>

> +
> +#include <libvfio.h>
> +
> +#include "mlx5_hw.h"

why are these two lines grouped individually?


> +/* Forward declaration =E2=80=94 cmd_exec polls events during command wa=
it */
> +static void mlx5st_process_events(struct mlx5st_device *dev);
> +
> +static const char *mlx5st_cmd_name(u16 opcode)
> +{
> +	switch (opcode) {
> +	case MLX5_CMD_OP_QUERY_HCA_CAP: return "QUERY_HCA_CAP";
> +	case MLX5_CMD_OP_INIT_HCA: return "INIT_HCA";
> +	case MLX5_CMD_OP_TEARDOWN_HCA: return "TEARDOWN_HCA";
> +	case MLX5_CMD_OP_ENABLE_HCA: return "ENABLE_HCA";
> +	case MLX5_CMD_OP_DISABLE_HCA: return "DISABLE_HCA";
> +	[...]
> +	}
> +}

Maybe line them up like:
Depends on your taste.

+	switch (opcode) {
+	case MLX5_CMD_OP_QUERY_HCA_CAP:	return "QUERY_HCA_CAP";
+	case MLX5_CMD_OP_INIT_HCA: 	return "INIT_HCA";
+	case MLX5_CMD_OP_TEARDOWN_HCA: 	return "TEARDOWN_HCA";
+	case MLX5_CMD_OP_ENABLE_HCA: 	return "ENABLE_HCA";
+	case MLX5_CMD_OP_DISABLE_HCA: 	return "DISABLE_HCA";
+	case MLX5_CMD_OP_QUERY_PAGES: 	return "QUERY_PAGES";
+ 	[...]

> +
> +	/*
> +	 * Compute signatures: mailbox blocks first, then cmd_queue_entry
> last.
> +	 * The sig must cover the final state including ownership=3D0x1, but
> +	 * we must not set ownership until after the sig is in place =E2=80=94
> +	 * XOR in the 0x1 without storing it to memory.
> +	 */

- " last"

+	/*
+	 * Compute signatures: mailbox blocks first, then cmd_queue_entry.

Thanks
 Manuel

