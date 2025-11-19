Return-Path: <linux-rdma+bounces-14615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6141C6C73D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3F7A3678AC
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379A32DEA6B;
	Wed, 19 Nov 2025 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFdjRfL7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2D2D24BF
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520651; cv=none; b=Tjhnu4CUpBTC8IWBtMQwI1QmbrbiUqoCG5ZP3DkQQw4MOcgak27b/gp3K6MIb6EOiYEVrGv4R7S68cBJBOR3/vlr8k55941+I8Gs7RLjA4h2Xl0JLjwFEIydVOyE4e1b+3hTVs4UWRZF7kDpTxcvSjwfa9lugKQtRiLqtvJ4ImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520651; c=relaxed/simple;
	bh=vHKevmHLyGKZlaBUyiPpZw4LR7UdmSikVoYh932YigM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFATkbKAEoNY3fYgw8UG9ZsKx7Fq5ARzjfWu/oX+F+tC+XM7UcAaSkERM81WETMOuvBfN3LK0jgDTDHXg06W5gIMlfd2IqOTFCSxctboLU5G3M7V4yJqAH1AzjrpTK+LdkcAtX+F8m3bSOFAc8CqQ2Q05Ooz64JzvBogAv1k63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFdjRfL7; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7895017c722so29925077b3.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 18:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520646; x=1764125446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5IyvxCRrbkSh8Mcd625VLTF156xLpP9WL9JoMonypU=;
        b=OFdjRfL77FNztKvaN22wSHD2nn8QsuFygkBb+NTtTNdxYQbi3cMZBsLxiHc/j5HnHL
         unnCP2o+0RsK4tdYzWduDUZZjUz83mUdg1wFrNS/kzBAgV/eq4O3PLD8UCHcqkrQfLPr
         wkhMhNE+HtZab7lhsnVhDTXPgO68B6kTinakn8e5PxtOjhicZ8oaU7EA2TqLgbXJUFGj
         X9vuXLoFJMyfRylVTCr++LweD+Eg30fbKNDcZikN+uQ74QtkfBdfGfh5kGBhjeOtR44n
         M+sBBqdHQQbGgm/lmjwZu7x1/Kzeox9iY2qwQ860EmqRLnTMFUs19A6ZLJD/PFEXDL0r
         f+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520646; x=1764125446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b5IyvxCRrbkSh8Mcd625VLTF156xLpP9WL9JoMonypU=;
        b=AVog+XvB88yAhsU5kRZKjNmw1zBLTN3or7bnYBbV7teMmrMBZy7GPI3qlkjAncpj6A
         l2ehnX9tH6eJZ8YJ2EHVYCrM6qQYXK4W8VkrpjAUgv/b8ZThK4auPmc+XLMqcb08ISZy
         K/5FRn2WesHmt6XD1YJTvCeKXZ4hzytcwDKWxdHW9W0ACXQvZMFqJWvMD+uyLxP/fX4u
         erirBqdQqYx4kl3/Dh2ZhUE2otb70jSqcIBJdp4II+MAJulGeq9JC8NowBvVTAk4RcRi
         u53BNglQYD/A1x43Bn21lBClBpkSWG67OuYYPYQm0+cKM5F/ghOg+zq7btNUN8NtolSS
         qWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNs6gnxE9QI5/6hCMsNLf0y7CG+FchcfMZtbFxNTTL7a5ammt1QStesXhV29e7PTy2djrL7abvj4Zp@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnxdjzq4h0WDSlqLMh2U8J3MfV8IDslnNv4emMub95jUX4YMc
	Uit6/MwEQdy5ufBx8Z57Xt+pd61LGjduwMhMhiXtgMqJEa+fVRQOhYNy
X-Gm-Gg: ASbGncsaA8mtqOS3owDrcNNtonhXzoIBZiijJt//xe6NpPGkt2A18xLKA/MMvTPOyvv
	WecTwhBVzYtFR4/3GlKB6ORPYSsHnZf7/9rprbHXMSsrWJAoT1Bn8Arcc90cc/B08bOixHQVhzK
	nSjvyjvhNbUiJNLqOPXqifqDvMZ/wcMP6tER8V2TOHIPTccA6VQQPGxpbfdbsv4rL8WkYZx3BZQ
	r04s/jajZ+4nAsUl5zQYJ4HIjIAqNJdZgeqzAHOtwZjfObdw1VM34AJ+i1wN8H1eSLaspxSFE8S
	3T9vHM7Z/BHHG/ujTt/MbdBoW2hcY+O3Av9RyqICJnHxa94w9ldPePM0oSOyNzYPcC88Hg76/g2
	21rHP23afafG8Izi98BwM1VgbomA3PQq+4BGnN52m16ET2Sgu4+BO4Y4xiv5NClG2nWeL9LiuEm
	OM7JMKYtVUqc4D/ivMrmlpIkaRDaAjW7KTH5fnoVIZTQ==
X-Google-Smtp-Source: AGHT+IF34NFysjzZi6Zm5GTXCEHIdEvIvK1+4tzj+xi4bvd9JqNWLiXkBn51Q2aJuIAIuibIlIc+zg==
X-Received: by 2002:a05:690c:a05c:b0:788:e1b:5f1a with SMTP id 00721157ae682-78929e0bb99mr132424287b3.6.1763520646218;
        Tue, 18 Nov 2025 18:50:46 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-788221781e9sm58999907b3.52.2025.11.18.18.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:50:45 -0800 (PST)
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
Subject: [PATCH net-next v5 6/6] selftest: netdevsim: test devlink default params
Date: Tue, 18 Nov 2025 18:50:36 -0800
Message-ID: <20251119025038.651131-7-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119025038.651131-1-daniel.zahka@gmail.com>
References: <20251119025038.651131-1-daniel.zahka@gmail.com>
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
 .../drivers/net/netdevsim/devlink.sh          | 116 +++++++++++++++++-
 1 file changed, 110 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 030762b203d7..1b529ccaf050 100755
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
@@ -135,6 +153,92 @@ params_test()
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
+	local default_debugfs
+	local new_debugfs
+	local expected_debugfs
+
+	default_debugfs=$(value_to_debugfs $expected_default)
+	new_debugfs=$(value_to_debugfs $new_value)
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


