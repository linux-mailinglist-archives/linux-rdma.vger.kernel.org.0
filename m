Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886016C0067
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCSJiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCSJiY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 05:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A4212AA
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 02:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84CDA60F56
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 09:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63785C433EF;
        Sun, 19 Mar 2023 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679218701;
        bh=2pdr9kflEZmhyF1oJf8I4ofKzD/9XaLh08DUMiifpak=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z+m2dtsVryI5igNJMY0N5sivZgDc0XR9PEGrXUVM/dxMixAgdc9dWeuqbnCdRvxKI
         E/UK9eK/IKT2+WnqlMkshjGV52JhRdI1q11YGsE0RQ1mwOSbx/34qe2hZ94VapwQEa
         Ii5cI3NP+HL7lzmfAP4i7GGEkh23K+WvRCD3zi3MT5m4JV4HQtQTmfapplOylEbhUA
         s2eOdjbYQE5Vd0gftgHWfgMVqiLDcnoBufRKbCd+bpGqZl33vY9LQUYdZN6rLd8du+
         3p0tovgPVS6FNEgsJC9cKa1SCxmk596TP6GWa/tYWZoOWp86qnUOe6irXqFNHJfQpa
         VBp476jhnNAqw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org
In-Reply-To: <20230315145231.931-1-shiraz.saleem@intel.com>
References: <20230315145231.931-1-shiraz.saleem@intel.com>
Subject: Re: [PATCH for-rc 0/4] irdma fixes
Message-Id: <167921869765.823112.13599966830995442481.b4-ty@kernel.org>
Date:   Sun, 19 Mar 2023 11:38:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed, 15 Mar 2023 09:52:27 -0500, Shiraz Saleem wrote:
> This series adds a few driver fixes for irdma.
> 
> Mustafa Ismail (3):
>   RDMA/irdma: Do not generate SW completions for NOPs
>   RDMA/irdma: Fix memory leak of PBLE objects
>   RDMA/irdma: Increase iWARP CM default rexmit count
> 
> [...]

Applied, thanks!

[1/4] RDMA/irdma: Do not generate SW completions for NOPs
      https://git.kernel.org/rdma/rdma/c/30ed9ee9a10a90
[2/4] RDMA/irdma: Fix memory leak of PBLE objects
      https://git.kernel.org/rdma/rdma/c/b69a6979dbaa24
[3/4] RDMA/irdma: Increase iWARP CM default rexmit count
      https://git.kernel.org/rdma/rdma/c/8385a875c9eecc
[4/4] RDMA/irdma: Add ipv4 check to irdma_find_listener()
      https://git.kernel.org/rdma/rdma/c/e4522c097ec10f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
