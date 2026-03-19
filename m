Return-Path: <linux-rdma+bounces-18369-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHFdL0dIu2kliQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18369-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:50:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5912C432F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AF46312B494
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 00:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208CA26E6F4;
	Thu, 19 Mar 2026 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHmJnWiE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4B255F28;
	Thu, 19 Mar 2026 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881181; cv=none; b=fYGj8MPG/v4Mwi2M9a7AkI0juvA3eGhZFzPe+odtPx/+TPCArgtzxsXHI/BAt8YMFGdETlP3BBgizxbaxos8dOb40CXLBsJLQJTZMv4aDVXSFv5g4uQ+aaZ4MCjuRwH1EdCpys9j/IndrIDZSYZ7cHYORTOYLEt/ysnX/3jHbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881181; c=relaxed/simple;
	bh=HZ0lar92sLMRaNa8laH9TDVx4n1nZmagXgaY0jQlMkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS3A0rXD9coT+dMHahmd8owbILwNe3z7OAP0/EX4s2yINAInLxOl3dVO8iQzVDpXiO1qr/wgDHBnp+gugJlQlpx6WSFQ3v5N/ExVN719PLHHV2CkptMKnO7dh0V35FbYC5Xi36w7E/JSMfLQFLZp62fhGGM3tFOIrLIh0AUgcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHmJnWiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDBCC19421;
	Thu, 19 Mar 2026 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881181;
	bh=HZ0lar92sLMRaNa8laH9TDVx4n1nZmagXgaY0jQlMkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHmJnWiESNcoE+Lq+ZjNTJl5eg5ibobIVZcL53zRxLXCHFjrc0RMhxq8iuasigVLA
	 tZ8JBdlnpVGNyfG07ujNuE4ypnWrtnQHOi9Y1p+7q1ZndKKW/6T+EEOPLQh0n5oBr1
	 je9zVRHO+kPci12NF83LTSfiSpTHxtIQUcLETgWSq+Nn3vVzoscsSFNbJlgj6VyTZ8
	 BMvG3aJWGBUh71Ma+C8Dfzi6K5GUcXy8FypZ/XZyYYJHNu7YVCvFfUXdOY/MpG2Qb7
	 IgVp92rRP4pFCF0QXvdhOui9xxZ4KOXC6ey5pmFI9PF6w+LbwXvGAyCsOQwbHIp3+m
	 crasM79ZV2+aQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v2 2/2] selftests: rds: Add -c config option to rds/config.sh
Date: Wed, 18 Mar 2026 17:46:18 -0700
Message-ID: <20260319004618.2577324-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319004618.2577324-1-achender@kernel.org>
References: <20260319004618.2577324-1-achender@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18369-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C5912C432F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds a new -c flag to config.sh that enables callers
to specify the file path of the config they would like to update.
If no config is specified, the default will be the .config of the
current directory.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/config.sh | 37 ++++++++++++++---------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
index 791c8dbe1095..e7a619d7cff0 100755
--- a/tools/testing/selftests/net/rds/config.sh
+++ b/tools/testing/selftests/net/rds/config.sh
@@ -6,15 +6,20 @@ set -u
 set -x
 
 unset KBUILD_OUTPUT
+CONF_FILE=""
+FLAGS=""
 
 GENERATE_GCOV_REPORT=0
-while getopts "g" opt; do
+while getopts "gc:" opt; do
   case ${opt} in
     g)
       GENERATE_GCOV_REPORT=1
       ;;
+    c)
+      CONF_FILE=$OPTARG
+      ;;
     :)
-      echo "USAGE: config.sh [-g]"
+      echo "USAGE: config.sh [-g] [-c config]"
       exit 1
       ;;
     ?)
@@ -24,30 +29,32 @@ while getopts "g" opt; do
   esac
 done
 
-CONF_FILE="tools/testing/selftests/net/config"
+if [[ "$CONF_FILE" != "" ]]; then
+	FLAGS="--file $CONF_FILE"
+fi
 
 # no modules
-scripts/config --file "$CONF_FILE" --disable CONFIG_MODULES
+scripts/config $FLAGS --disable CONFIG_MODULES
 
 # enable RDS
-scripts/config --file "$CONF_FILE" --enable CONFIG_RDS
-scripts/config --file "$CONF_FILE" --enable CONFIG_RDS_TCP
+scripts/config $FLAGS --enable CONFIG_RDS
+scripts/config $FLAGS --enable CONFIG_RDS_TCP
 
 if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
 	# instrument RDS and only RDS
-	scripts/config --file "$CONF_FILE" --enable CONFIG_GCOV_KERNEL
-	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_ALL
-	scripts/config --file "$CONF_FILE" --enable GCOV_PROFILE_RDS
+	scripts/config $FLAGS --enable CONFIG_GCOV_KERNEL
+	scripts/config $FLAGS --disable GCOV_PROFILE_ALL
+	scripts/config $FLAGS --enable GCOV_PROFILE_RDS
 else
-	scripts/config --file "$CONF_FILE" --disable CONFIG_GCOV_KERNEL
-	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_ALL
-	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_RDS
+	scripts/config $FLAGS --disable CONFIG_GCOV_KERNEL
+	scripts/config $FLAGS --disable GCOV_PROFILE_ALL
+	scripts/config $FLAGS --disable GCOV_PROFILE_RDS
 fi
 
 # need network namespaces to run tests with veth network interfaces
-scripts/config --file "$CONF_FILE" --enable CONFIG_NET_NS
-scripts/config --file "$CONF_FILE" --enable CONFIG_VETH
+scripts/config $FLAGS --enable CONFIG_NET_NS
+scripts/config $FLAGS --enable CONFIG_VETH
 
 # simulate packet loss
-scripts/config --file "$CONF_FILE" --enable CONFIG_NET_SCH_NETEM
+scripts/config $FLAGS --enable CONFIG_NET_SCH_NETEM
 
-- 
2.43.0


