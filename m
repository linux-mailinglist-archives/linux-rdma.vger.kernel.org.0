Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EEEE21EF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfJWRkF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 13:40:05 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33740 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfJWRkF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 13:40:05 -0400
Received: by mail-wr1-f52.google.com with SMTP id s1so14284647wro.0
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZ8n6S4NfaKtQTi/gcDWbIv2/8+bvhyDihcDm9eCIPA=;
        b=O+aqbRZ1MFusrcwePHUxgPWrdkHumhkAX3g0NotQ30+a0L6aecwVBFItRnGlohitCk
         1+rOOXmC467+5CTMC1RUOwWsafKB77Vfr+B8Abg/vlLXjZ6jcT3TKFButLPjNVOFlX7H
         8Ff4oEkh/WogGGlDTIyV2REOP/i79DDiP/NT7TiSfozWpjdiH0AkeGCDnsP2qOm11Go4
         vB46Hr7h7mLfDq+2XWOcrjOcg3VOzLauT+MghqceqAmfgL+B9BRzUPHpasGPkHsAeqg1
         klmsjvmSSx1RHtERafv7PEkyPK+sPODT5kX2OwxZ4vousfVC+RRQQXSMXRKNYt+KL/tL
         2kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZ8n6S4NfaKtQTi/gcDWbIv2/8+bvhyDihcDm9eCIPA=;
        b=K2hEzvSk2lduMscncR0goI4w7j/AlXZaZoj3oFwEHROPlFQTb8/cbXrfmMA7bFs5ug
         Tnnp1VAvwsHJb7QihyxHs3Y6v3FGAjIWCWdN9Upl0CBEpAMAxuy9B0VmJKUwGiEo8at3
         xh7N1GPAw0ht5yDwSxNP3IfslXfslFS4pNf8QtLtNfOdNzeLPcog/BVnxDSv5sUMivNi
         g9dI/9ng8nG1IpbteewYQSEiy5hDBcicXo1cW6cp12vuNPGluvbWUJFHhXVhyyj0Jvra
         FOxDAXwBg+WpDoR5QLWfNEiCh2cV366Ff+3G4LmNgL2P11AlS43JC24EDXOM4CqSWB28
         DdFw==
X-Gm-Message-State: APjAAAUXfctuLtOlV1Hr0ElsffTJIv3/0UKsQRfoDhv2WupwrVGoGbpW
        q9Zzi2ovNPJCdcx7qBwKB8e37YXp5FY=
X-Google-Smtp-Source: APXvYqynxPAk3t+DQvgVQV5aAg4uWVHa/GYyw+fEgm+NRCrfWhGY8+8l9XRxzO+8rZuFH9jjZEQ5iA==
X-Received: by 2002:adf:da4e:: with SMTP id r14mr9174307wrl.375.1571852402155;
        Wed, 23 Oct 2019 10:40:02 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id u1sm33183252wru.90.2019.10.23.10.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:40:01 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] selftests: rdma: Add rdma tests
Date:   Wed, 23 Oct 2019 20:39:54 +0300
Message-Id: <20191023173954.29291-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a new directory to house the rdma specific tests and add the first
rdma_dev.sh test that checks the renaming and setting of adaptive
moderation using the rdma tool for the available RDMA devices in the
system.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 tools/testing/selftests/Makefile         |  1 +
 tools/testing/selftests/rdma/Makefile    |  6 ++
 tools/testing/selftests/rdma/lib.sh      | 55 ++++++++++++++++
 tools/testing/selftests/rdma/rdma_dev.sh | 83 ++++++++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/rdma/Makefile
 create mode 100644 tools/testing/selftests/rdma/lib.sh
 create mode 100755 tools/testing/selftests/rdma/rdma_dev.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c3feccb99ff5..870b9d0c36c9 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -37,6 +37,7 @@ TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
+TARGETS += rdma
 TARGETS += rseq
 TARGETS += rtc
 TARGETS += seccomp
diff --git a/tools/testing/selftests/rdma/Makefile b/tools/testing/selftests/rdma/Makefile
new file mode 100644
index 000000000000..56df64b9b5d9
--- /dev/null
+++ b/tools/testing/selftests/rdma/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for rdma selftests
+
+TEST_PROGS := rdma_dev.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/rdma/lib.sh b/tools/testing/selftests/rdma/lib.sh
new file mode 100644
index 000000000000..5f1cc08bc6b2
--- /dev/null
+++ b/tools/testing/selftests/rdma/lib.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+EXIT_STATUS=0
+RET=0
+#Kselftest framework requirement - SKIP code is 4
+ksft_skip=4
+
+check_and_skip()
+{
+	local rc=$1
+	local msg=$2
+
+	if [ $rc -ne 0 ]; then
+		echo "SKIP: $msg"
+		exit $ksft_skip
+	fi
+}
+
+check_ret_val()
+{
+	local rc=$1
+	local msg=$2
+
+	if [[ $RET -eq 0 && $rc -ne 0 ]]; then
+		RET=$rc
+		retmsg=$msg
+	fi
+}
+
+print_results()
+{
+	local test_name=$1
+
+	if [[ $RET -ne 0 ]]; then
+		EXIT_STATUS=1
+		printf "TEST: %-60s [FAIL]\n" "$test_name"
+		if [[ ! -z "$retmsg" ]]; then
+			printf "\t%s\n" "$retmsg"
+		fi
+		return 1
+	fi
+
+	printf "TEST: %-60s [OK]\n" "$test_name"
+	return 0
+}
+
+run_tests()
+{
+	local cur_test
+
+	for cur_test in ${ALL_TESTS}; do
+		$cur_test
+	done
+}
diff --git a/tools/testing/selftests/rdma/rdma_dev.sh b/tools/testing/selftests/rdma/rdma_dev.sh
new file mode 100755
index 000000000000..ca3ae7ddac9b
--- /dev/null
+++ b/tools/testing/selftests/rdma/rdma_dev.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+lib=$(dirname $0)/lib.sh
+source $lib
+
+ALL_TESTS="
+	test_rename
+	test_adaptive_moderation
+"
+
+test_rename()
+{
+	local dev=$RDMA_DEV
+
+	rdma dev set $dev name "tmp_$dev"
+	check_ret_val $? "Failed to rename $dev to tmp_$dev"
+
+	rdma dev set tmp_$dev name $dev
+	check_ret_val $? "Failed to restore $dev name"
+
+	print_results "$dev: Rename"
+}
+
+test_adaptive_moderation()
+{
+	local dev=$RDMA_DEV
+
+	rdma dev show $dev -d | grep -qE "adaptive-moderation"
+	check_and_skip $? "Setting adaptive-moderation is not supported"
+
+	rdma dev show $dev -d | grep -qE "adaptive-moderation off"
+	if [ $? -ne 0 ]; then
+		rdma dev set $dev adaptive-moderation off
+		check_ret_val $? "$dev: Failed to set adaptive-moderation to on"
+
+		rdma dev set $dev adaptive-moderation on
+		check_ret_val $? "$dev: Failed to restroe adaptive-moderation to off"
+	else
+		rdma dev set $dev adaptive-moderation on
+		check_ret_val $? "$dev: Failed to set adaptive-moderation to on"
+
+		rdma dev set $dev adaptive-moderation off
+		check_ret_val $? "$dev: Failed to restroe adaptive-moderation to off"
+	fi
+
+	print_results "$dev: Setting adaptive-moderation"
+}
+
+prepare()
+{
+	TMP_LIST_RDMADEV="$(mktemp)"
+	if [ ! -e $TMP_LIST_RDMADEV ]; then
+		echo "FAIL: Failed to create temp file to hold rdma devices"
+		exit 1
+	fi
+}
+
+cleanup()
+{
+	rm $TMP_LIST_RDMADEV
+}
+
+trap cleanup EXIT
+
+check_and_skip $(id -u) "Need root privileges"
+
+rdma dev show 2>/dev/null >/dev/null
+check_and_skip $? "Can not run the test without rdma tool"
+
+prepare
+
+rdma dev show | grep '^[0-9]' | cut -d" " -f 2 | cut -d: -f1> "$TMP_LIST_RDMADEV"
+test -s "$TMP_LIST_RDMADEV"
+check_and_skip $? "No RDMA devices available"
+
+while read rdma_dev
+do
+	RDMA_DEV=$rdma_dev
+	run_tests
+done < $TMP_LIST_RDMADEV
+
+exit $EXIT_STATUS
-- 
2.20.1

