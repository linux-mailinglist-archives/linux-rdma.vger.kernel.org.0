Return-Path: <linux-rdma+bounces-13864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB98BDB4EF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 22:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D66954EECA0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20DB30217B;
	Tue, 14 Oct 2025 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2tnmVxt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756442BD5BC;
	Tue, 14 Oct 2025 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474824; cv=none; b=EFgO6rcjC85Cl6cmaw2w5JiSSW8oKV7a2DUyGX5NR1gAY+98Tb8HPo/BYXqPc6RueLfmHT+EBJw6oVZgMV+pWDn97rXBa/tNgCpxAK1jTbOU0Zyx3A3Hq0mGEh28sqY69iwzUuBBmWbPYqV1tz/MyvFqr9a43WkBxe3NxBFHm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474824; c=relaxed/simple;
	bh=BeXYJ7TDDA12WXKKfS+OYrqQ57gzlsQbH9llrXbQhUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qFSiM+cLyn5cTflp8gP3bRymc238FI4zEJ2DP1ckKnlJzkhKmAbWBetjr0s3LPg4I3waIHlKcPfOK8VuNEHzWDSctIsS/9Th8KDakYcRsvJKGWvobe4IAgT/0mBecNAN1+nQpjZPoSr24YDR38SnjSjCGD8UiznLpt5a+vmktLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2tnmVxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB18C4CEE7;
	Tue, 14 Oct 2025 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760474824;
	bh=BeXYJ7TDDA12WXKKfS+OYrqQ57gzlsQbH9llrXbQhUQ=;
	h=From:Date:Subject:To:Cc:From;
	b=s2tnmVxt8iPDADIbTLFWzPs01vJJBfChUPoVQYRyU+SLtHET8iGF+ti7bcY+wmW6j
	 foXPNZOspgMzU1r1XC3auiH8DSPYhy2gmxmQJZs69DpBLH8JL6i3wwBjJ75jq4V8US
	 xQfcx5v+trLzkka7CifMbEDuBZuX+rZBQ0SqngOREkgaZVxyz8U/I6RdzgJimSGHFa
	 qQtMuUpbaT3cmMdo4GiJKw1pZxPkOAgWNajAewOyzfKuuHNsORZdy7fpEwmKk1ZvyN
	 RR1+OP8QSs+BdrIWfdpr6a9xsdf4wcZbGKi69HX/j3+T4oJ6F+8H8+XcJQzc3ELv+f
	 O9nbMuB+88KLQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 14 Oct 2025 13:46:49 -0700
Subject: [PATCH net] net/mlx5e: Return 1 instead of 0 in invalid case in
 mlx5e_mpwrq_umr_entry_size()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-v1-1-dc186b8819ef@kernel.org>
X-B4-Tracking: v=1; b=H4sIALi27mgC/yWNQQrCMBAAv1L27EJTU1G/IhJCs9EFk9RNjbWlf
 zfocRiYWSGTMGU4NysIFc6cYgW1a2C423gjZFcZurbrVas0hsfcE9qS2OFCktBxQS8p/I0J41u
 e5hXEUJzkYzIvhHRw+jSoo9V7DzU9Cnmef9sLRJrgum1f7BnEIosAAAA=
X-Change-ID: 20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-e6d49c18a43f
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, patches@lists.linux.dev, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2781; i=nathan@kernel.org;
 h=from:subject:message-id; bh=BeXYJ7TDDA12WXKKfS+OYrqQ57gzlsQbH9llrXbQhUQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBnvth1JEHQ6uG/+jVmr7pfkMvF7x4ea3zytzHqfkT+Za
 +GUKVrVHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAie48zMsxXuiAQ1HdP1aVo
 av8pGckjFzXN9hy0mha7OXj7x/UMSuaMDL887qgc+/U28E/J6jTOnhMXvx9+Wbx9Su8R42ndcV1
 f9vMCAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with Clang 20 or newer, there are some objtool warnings
from unexpected fallthroughs to other functions:

  vmlinux.o: warning: objtool: mlx5e_mpwrq_mtts_per_wqe() falls through to next function mlx5e_mpwrq_max_num_entries()
  vmlinux.o: warning: objtool: mlx5e_mpwrq_max_log_rq_size() falls through to next function mlx5e_get_linear_rq_headroom()

LLVM 20 contains an (admittedly problematic [1]) optimization [2] to
convert divide by zero into the equivalent of __builtin_unreachable(),
which invokes undefined behavior and destroys code generation when it is
encountered in a control flow graph.

mlx5e_mpwrq_umr_entry_size() returns 0 in the default case of an
unrecognized mlx5e_mpwrq_umr_mode value. mlx5e_mpwrq_mtts_per_wqe(),
which is inlined into mlx5e_mpwrq_max_log_rq_size(), uses the result of
mlx5e_mpwrq_umr_entry_size() in a divide operation without checking for
zero, so LLVM is able to infer there will be a divide by zero in this
case and invokes undefined behavior. While there is some proposed work
to isolate this undefined behavior and avoid the destructive code
generation that results in these objtool warnings, code should still be
defensive against divide by zero.

As the WARN_ONCE() implies that an invalid value should be handled
gracefully, return 1 instead of 0 in the default case so that the
results of this division operation is always valid.

Fixes: 168723c1f8d6 ("net/mlx5e: xsk: Use umr_mode to calculate striding RQ parameters")
Link: https://lore.kernel.org/CAGG=3QUk8-Ak7YKnRziO4=0z=1C_7+4jF+6ZeDQ9yF+kuTOHOQ@mail.gmail.com/ [1]
Link: https://github.com/llvm/llvm-project/commit/37932643abab699e8bb1def08b7eb4eae7ff1448 [2]
Closes: https://github.com/ClangBuiltLinux/linux/issues/2131
Closes: https://github.com/ClangBuiltLinux/linux/issues/2132
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 3692298e10f2..c9bdee9a8b30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -100,7 +100,7 @@ u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode)
 		return sizeof(struct mlx5_ksm) * 4;
 	}
 	WARN_ONCE(1, "MPWRQ UMR mode %d is not known\n", mode);
-	return 0;
+	return 1;
 }
 
 u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,

---
base-commit: 4f86eb0a38bc719ba966f155071a6f0594327f34
change-id: 20251014-mlx5e-avoid-zero-div-from-mlx5e_mpwrq_umr_entry_size-e6d49c18a43f

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


