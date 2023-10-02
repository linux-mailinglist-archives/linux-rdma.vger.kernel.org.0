Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA517B5C47
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjJBUzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 16:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBUzv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 16:55:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B609C9
        for <linux-rdma@vger.kernel.org>; Mon,  2 Oct 2023 13:55:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5905AC433C8;
        Mon,  2 Oct 2023 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696280148;
        bh=t4+IE1MpYk7ZH0O/BglLFmWzX8a+Sq8oLP+hPz5YdNk=;
        h=From:Subject:Date:To:Cc:From;
        b=mxtX8eOumjYl2VOI4NHMAoRbtGlcIskbqAwOjEvBcznMJJjAupnWDCMvZfLUsMpvE
         66YqyaOT1kstxZ3VhWbae8fw8Q8wB+jeDDlM3f8oLZABYzsGsr0c+SAsKxNGJqbZKO
         K11IBXfI3lE9hE9SZ6TK/G6yytmKFE6xAEiU1HZLIDZU9piFLz/bmUzrin29FLUxhc
         YY2d7HoDXovsEEQ3/jXbPjoAIGbWRftpNBklJLXtKSoFkLtyEZia1NyYHAKDocYJOI
         jwJzWzSDa3hTdkLodHWrG86QFD0LJk6lfPAYR+0pPG/RQqWDWX2YvRkqIIkz58fPdJ
         Ov/oIHgoAIhiA==
From:   Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] Fix a couple recent instances of
 -Wincompatible-function-pointer-types-strict from ->mode_get()
 implementations
Date:   Mon, 02 Oct 2023 13:55:19 -0700
Message-Id: <20231002-net-wifpts-dpll_mode_get-v1-0-a356a16413cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcuG2UC/x2M7QpAMBRAX0X3t9U+SngVSWN33GLWJpS8u5uf5
 9Q5D2RMhBna4oGEJ2XaA4MqC5gWG2YU5JhBS22UlFoEPMRFPh5ZuLiuw7Y7HGaWuqrRW+O8akb
 gPCb0dP/rrn/fD0kGTvtqAAAA
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vadfed@fb.com
Cc:     arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
        netdev@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        richardcochran@gmail.com, jonathan.lemon@gmail.com,
        saeedm@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=nathan@kernel.org;
 h=from:subject:message-id; bh=t4+IE1MpYk7ZH0O/BglLFmWzX8a+Sq8oLP+hPz5YdNk=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKnSekH5UvIHjqx4mvOA6dOdOLne7kxO36lhB/N9/NOem
 NseXfmxo5SFQYyDQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEwkQZvhn3FFw96NGQ+ui3Js
 36JmUXP/t9qyBq2Nmm95nDN/V8yeK8jw32dhdGzHx7lR6lOCmA8bVZ/ZdEX9Y1bX/0gGxoY5JmV
 7GQE=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

This series fixes a couple of instances of
-Wincompatible-function-pointer-types-strict that were introduced by a
recent series that added a new type of ops, struct dpll_device_ops,
along with implementations of the callback ->mode_get() that had a
mismatched mode type.

This warning is not currently enabled for any build but I am planning on
submitting a patch to add it to W=1 to prevent new instances of the
warning from popping up while we try and fix the existing instances in
other drivers.

This series is based on current net-next but if they need to go into
individual maintainer trees, please feel free to take the patches
individually.

Cheers,
Nathan

---
Nathan Chancellor (2):
      ptp: Fix type of mode parameter in ptp_ocp_dpll_mode_get()
      mlx5: Fix type of mode parameter in mlx5_dpll_device_mode_get()

 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 4 ++--
 drivers/ptp/ptp_ocp.c                          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 35766690d675f63c111afa0a2f5286b74a5b5cc2
change-id: 20231002-net-wifpts-dpll_mode_get-268efa3df19b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

