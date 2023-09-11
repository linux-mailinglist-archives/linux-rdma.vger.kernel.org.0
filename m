Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59879B448
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 02:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357891AbjIKWGs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbjIKLOs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 07:14:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C8ECF0;
        Mon, 11 Sep 2023 04:14:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38324C433C8;
        Mon, 11 Sep 2023 11:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694430883;
        bh=/jDhCctJTTpe+yJp1NP5C7CQXkmhOYjw0kp2qq1SFo4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=mIJ7JuzOEAJBzg9U6TTsgG7GG40rJS1CGg+1I9F2E4dbhM7unP+Bpy61mn14B1LeF
         CsR1WWEaQzKt5MFWPra0wqSQf5KHsM6DNAs5xBDRT937x3EkTwlq10PrgCCC4Z4vHX
         jImRmCIVhcoPZlNGVVdjPnW6pp9uF2WuGhBiNH2MHnv6AIFYLM+4w2okQeWpxolcTn
         ou3JfbeyXNcqMDpoNPUoZ4igyMqv8nvALDrJe0mJoyjxSHKgVrbJinnz9nezwGCn7l
         9XWUsnK0M5PGTbkRgAOVzZQMOkZQ6zgD80o0VxH7uGGr+ClJKqTk46cm311sjFeKy1
         0MqsPMSMxQ/wA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823092912.122674-1-krzysztof.kozlowski@linaro.org>
References: <20230823092912.122674-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] IB: use capital "OR" for multiple licenses in SPDX
Message-Id: <169443088009.186307.7609206850299994174.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 14:14:40 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 23 Aug 2023 11:29:12 +0200, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> 

Applied, thanks!

[1/1] IB: use capital "OR" for multiple licenses in SPDX
      https://git.kernel.org/rdma/rdma/c/3ec648c631d27a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
