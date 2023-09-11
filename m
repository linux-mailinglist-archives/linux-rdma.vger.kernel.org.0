Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147B579AFC9
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Sep 2023 01:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357861AbjIKWGi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Sep 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbjIKL4b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Sep 2023 07:56:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE6E3
        for <linux-rdma@vger.kernel.org>; Mon, 11 Sep 2023 04:56:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D7EC433C7;
        Mon, 11 Sep 2023 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694433387;
        bh=6PgaeHTvbPtjIkk/w+QXRtsSjNnQnV/2XfGmxZ66IMo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OA/AGuoyC1eLTVBsQCmSaGAkQoVxZEfw+5ED8V7RIVCYSCodwAkFACBhwDd984dbM
         tfzL7haAqYgaYoHpJiVWy9pe8c/QuAfdR/Sxi7iDHs8cV6DCfcOLnPdbHix2unqHaQ
         bp8JKdQAlBc+zlES61CFi5iFtf2/MRNgIHJ6pANGzro/u2mvXpNOHz+kCvDROyQwYE
         G3y6VU76qPLllpr6CK4LWQwc87jPOJEKT7MlLT31DzuRb3c5ZQEhXnHCnm+9MIiVG8
         fQwdH8XcLd5+DIe81tSvrq9s+ANbHP4yI5bmFiC1XlqOtaobFce5/y8bMKzVmQWOMb
         sY943K2LTjliA==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Cc:     jgg@ziepe.ca
In-Reply-To: <20230905145822.446263-1-bmt@zurich.ibm.com>
References: <20230905145822.446263-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH v2] RDMA/siw: Fix connection failure handling
Message-Id: <169443338361.215131.4565278378412277787.b4-ty@kernel.org>
Date:   Mon, 11 Sep 2023 14:56:23 +0300
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


On Tue, 05 Sep 2023 16:58:22 +0200, Bernard Metzler wrote:
> In case immediate MPA request processing fails, the newly
> created endpoint unlinks the listening endpoint and is
> ready to be dropped. This special case was not handled
> correctly by the code handling the later TCP socket close,
> causing a NULL dereference crash in siw_cm_work_handler()
> when dereferencing a NULL listener. We now also cancel
> the useless MPA timeout, if immediate MPA request
> processing fails.
> 
> [...]

Applied, thanks!

[1/1] RDMA/siw: Fix connection failure handling
      https://git.kernel.org/rdma/rdma/c/53a3f777049771

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
