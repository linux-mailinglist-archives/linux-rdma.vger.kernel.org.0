Return-Path: <linux-rdma+bounces-14579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B807C66A78
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B6874E9432
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 00:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00832836B5;
	Tue, 18 Nov 2025 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCSypgpE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6A26ED28
	for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425498; cv=none; b=IPg50joau2ktV+0bIFJNJ3j+YacfLm4/X6gI3khbUd0d0tz3oBMFSltd7B4Ahdz28XuCy2HlUs8BlXQqWRkhYCG7e6yK31kyC6qVlEEmptaHVyzHzgLhO1zo/Y8OcifklS5bXbFCRZfg+HgdgwK8rqk5k5vgWXuYmCLMgLyR9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425498; c=relaxed/simple;
	bh=VBV4wTTE4imuwCtDr+8mVLpoDQnQGoRXrQDIn/8Nmdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEFCD6rZn91Kz2UGCtH1qqrNs1Ugg0Mdne5FNa3fErA/vNcI43K3XQzqVZlNefkXe3Wbf+XJhCtVVl/L/d7E2BypBxNVEAE5yET5zh2PNS+PNu31fwD0DGMLX/2p8XD6yujYiJ0dESpHaNPPhEzb6Y0FXHPy0f6Zxu+OSOvGzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCSypgpE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-786635a8ce4so40845167b3.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 16:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763425495; x=1764030295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GenjXWqNInuYwre7qbdm1o4nfBEHIUP7s9yd4imsMSU=;
        b=jCSypgpEWAMyarruHDWV+nByd0bFtRniVhw6oe47Rmz70CMBiY7UWd2YKjrwE3ucRC
         SEc35fprsPwLQ1d0B3Wi1xZEErwrWVjlLl9yBgcDc7IlgIWJS40EcS9HoZ/yIN7cOxbk
         4sOt1I8hx5RMbtAYVdH27S20zuTdh7CDgwC2MpHnWQuHnT4fjDNTl/wu7l2L/VcxmCtM
         xzUQX6CdplIKyw4AWqgJIKS8APJKiTr0B7Rb3xiCDLrSIyHOoVmNxgt62mCDXwoM2M7A
         Tn4z0AURtChYhEGlDJdZ7KItk5RAQ+yQQ9KctFZLYNohtZDdIgPZt+0J6qgvlYEyzCAM
         rpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763425495; x=1764030295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GenjXWqNInuYwre7qbdm1o4nfBEHIUP7s9yd4imsMSU=;
        b=DUNk40HzTCLlUi2HuhyCxfXl4c+drAMUjsOcNrkM+tmxMfQdAe9wCgLAeDJ37+1YMw
         ONNrmpO9LaYHpDNsE9HRUcBO+xn4YdmMjBdbxyPgoAQaAxwelMhtVsQT8IyWVRrP67+N
         2HVfVUAP1dwBy1DjTXKVtM2PFITEyWUXcblTJ1AK6oCQM8/BOrWlteq+V785shnY8AsU
         leY4BwTGrkDy8p1fL0FXjjnyNqDaipGcEO1KKdc9w1r0zOK/l5KdJrfZwzvrNAxpZAZ5
         WaFDSc1Befbt7VkSr2bC7t7wVccAUsrVBbf7UXWECyEi3CQ4ZQ99C9NBBQ3h7EfmzEfv
         Mg/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJP8/AHTd70D10lzLmwJE6K3XqDEbbQgaHm/2mBBMq/xo02rw6qNR5iLMp8bmdDbvK+NqfAwzkTT3C@vger.kernel.org
X-Gm-Message-State: AOJu0YziF0XPFX6biw4ir0AL9M4pHsq9MlY0MgbfwofTp5ok8LFANxAR
	76MqbsTEjWXnrYytaPDtWOGgndMzq+FtpPvdf6MFijRrzj8stgoTJTi2
X-Gm-Gg: ASbGncsF9NgfrKR+84x+WkOGy7oIN7tPQTWshMCtAvl1cMRNPGkhnj5y/hfe3I5F4EL
	gLh5aplYi2SBhRBiyBk26lYSF+r0jonPSrjC+M8/5vYt4jcyPNimkVCoTQghSePjQ38yBm9b2D4
	zYfZynJU7zTccrfe0FMUraSaSS42WMYjwH0lXCmqe2Q5fcou+NsC46kOEy5WQTk8ZoeFoVgMUkB
	R1oV9jqCDI8cyQeccvvxIX3AbuvWpWbAZUOY7K+Z5efqTe6ExQcG1eZ+BVS6WANfSF2YrXElmAw
	RfjcpuDykt6hZapLHc3taGxxbk5VeyadMien+cFGd7SercFGCThbkkCcWyBfhDeI9DcCIHoB0Er
	PVLT19jiTWFV3FeEumZoO8lh4PIeLDQheYbugA0hK8mhJJBqyMcopQBBX+ZKUqUso2OT6R13NYa
	siwYq3k2WfxGZrwk8XfcEC
X-Google-Smtp-Source: AGHT+IG3sVHIKUgzGse+OqII+TDOwybzXE1KBDn6uL/BlWk2Z3KoPdn+jhe/F8558MWvBkxr5uFXQg==
X-Received: by 2002:a05:690e:2598:b0:63f:a2a7:8f1f with SMTP id 956f58d0204a3-641e75bf86bmr8550441d50.27.1763425495455;
        Mon, 17 Nov 2025 16:24:55 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-788221224d8sm47135867b3.38.2025.11.17.16.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:24:53 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v4 6/6] selftest: netdevsim: test devlink default params
Date: Mon, 17 Nov 2025 16:24:32 -0800
Message-ID: <20251118002433.332272-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118002433.332272-1-daniel.zahka@gmail.com>
References: <20251118002433.332272-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test querying default values and resetting to default values for
netdevsim devlink params.

This should cover the basic paths of interest: driverinit and
non-driverinit cmodes, as well as bool and non-bool value
type. Default param values of type bool are encoded with u8 netlink
type as opposed to flag type, so that userspace can distinguish
"not-present" from false.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 113 +++++++++++++++++-
 1 file changed, 107 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 030762b203d7..e642da9dd0c1 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -3,7 +3,8 @@
 
 lib_dir=$(dirname $0)/../../../net/forwarding
 
-ALL_TESTS="fw_flash_test params_test regions_test reload_test \
+ALL_TESTS="fw_flash_test params_test  \
+	   params_default_test regions_test reload_test \
 	   netns_reload_test resource_test dev_info_test \
 	   empty_reporter_test dummy_reporter_test rate_test"
 NUM_NETIFS=0
@@ -78,17 +79,28 @@ fw_flash_test()
 param_get()
 {
 	local name=$1
+	local attr=${2:-value}
+	local cmode=${3:-driverinit}
 
 	cmd_jq "devlink dev param show $DL_HANDLE name $name -j" \
-	       '.[][][].values[] | select(.cmode == "driverinit").value'
+	       '.[][][].values[] | select(.cmode == "'"$cmode"'").'"$attr"
 }
 
 param_set()
 {
 	local name=$1
 	local value=$2
+	local cmode=${3:-driverinit}
 
-	devlink dev param set $DL_HANDLE name $name cmode driverinit value $value
+	devlink dev param set $DL_HANDLE name $name cmode $cmode value $value
+}
+
+param_set_default()
+{
+	local name=$1
+	local cmode=${2:-driverinit}
+
+	devlink dev param set $DL_HANDLE name $name default cmode $cmode
 }
 
 check_value()
@@ -97,12 +109,18 @@ check_value()
 	local phase_name=$2
 	local expected_param_value=$3
 	local expected_debugfs_value=$4
+	local cmode=${5:-driverinit}
 	local value
+	local attr="value"
 
-	value=$(param_get $name)
-	check_err $? "Failed to get $name param value"
+	if [[ "$phase_name" == *"default"* ]]; then
+		attr="default"
+	fi
+
+	value=$(param_get $name $attr $cmode)
+	check_err $? "Failed to get $name param $attr"
 	[ "$value" == "$expected_param_value" ]
-	check_err $? "Unexpected $phase_name $name param value"
+	check_err $? "Unexpected $phase_name $name param $attr"
 	value=$(<$DEBUGFS_DIR/$name)
 	check_err $? "Failed to get $name debugfs value"
 	[ "$value" == "$expected_debugfs_value" ]
@@ -135,6 +153,89 @@ params_test()
 	log_test "params test"
 }
 
+value_to_debugfs()
+{
+	local value=$1
+
+	case "$value" in
+		true)
+			echo "Y"
+			;;
+		false)
+			echo "N"
+			;;
+		*)
+			echo "$value"
+			;;
+	esac
+}
+
+test_default()
+{
+	local param_name=$1
+	local new_value=$2
+	local expected_default=$3
+	local cmode=${4:-driverinit}
+	local default_debugfs=$(value_to_debugfs $expected_default)
+	local new_debugfs=$(value_to_debugfs $new_value)
+	local expected_debugfs
+
+	expected_debugfs=$default_debugfs
+	check_value $param_name initial-default $expected_default $expected_debugfs $cmode
+
+	param_set $param_name $new_value $cmode
+	check_err $? "Failed to set $param_name to $new_value"
+
+	expected_debugfs=$([ "$cmode" == "runtime" ] && echo "$new_debugfs" || echo "$default_debugfs")
+	check_value $param_name post-set $new_value $expected_debugfs $cmode
+
+	devlink dev reload $DL_HANDLE
+	check_err $? "Failed to reload device"
+
+	expected_debugfs=$new_debugfs
+	check_value $param_name post-reload-new-value $new_value $expected_debugfs $cmode
+
+	param_set_default $param_name $cmode
+	check_err $? "Failed to set $param_name to default"
+
+	expected_debugfs=$([ "$cmode" == "runtime" ] && echo "$default_debugfs" || echo "$new_debugfs")
+	check_value $param_name post-set-default $expected_default $expected_debugfs $cmode
+
+	devlink dev reload $DL_HANDLE
+	check_err $? "Failed to reload device"
+
+	expected_debugfs=$default_debugfs
+	check_value $param_name post-reload-default $expected_default $expected_debugfs $cmode
+}
+
+params_default_test()
+{
+	RET=0
+
+	if ! devlink dev param help 2>&1 | grep -q "value VALUE | default"; then
+		echo "SKIP: devlink cli missing default feature"
+		return
+	fi
+
+	# Remove side effects of previous tests. Use plain param_set, because
+	# param_set_default is a feature under test here.
+	param_set max_macs 32 driverinit
+	check_err $? "Failed to reset max_macs to default value"
+	param_set test1 true driverinit
+	check_err $? "Failed to reset test1 to default value"
+	param_set test2 1234 runtime
+	check_err $? "Failed to reset test2 to default value"
+
+	devlink dev reload $DL_HANDLE
+	check_err $? "Failed to reload device for clean state"
+
+	test_default max_macs 16 32 driverinit
+	test_default test1 false true driverinit
+	test_default test2 100 1234 runtime
+
+	log_test "params default test"
+}
+
 check_region_size()
 {
 	local name=$1
-- 
2.47.3


