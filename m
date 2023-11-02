Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA217DEDA8
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 08:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKBHus (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 03:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjKBHuq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 03:50:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7039C128
        for <linux-rdma@vger.kernel.org>; Thu,  2 Nov 2023 00:50:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9becde9ea7bso347526266b.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Nov 2023 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698911440; x=1699516240; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfN3ggQoi0TjXocqgo8TxZ/fpcbFAad/4kML7blXAcs=;
        b=RjybZXmaLngV1Ywz2f2l3WlNTjpr7oKFz3a7hBJ5KacnvPtDqorrldbmQVlvW5hhke
         R1LFPY4HZbv6W1NNWSnEZ6OSwjUlJBs4v32Icq9WFZ3B05Xj30Iuk2KceTN7k1n3lKxn
         r5JD49kqOSU1flblNbxkmbV4VG520fgZpPqcOLqkOJ3dpr6hh1z0zbp15ns6gpCTbgM1
         cuYGEbDTMU9PbWapFEPVQHBlqaOagJSUXxrYBFksbZULhDksUjizh634gWSx43/EyuI0
         lbagHRjBFxeu1G2+0iQ8jaTADHvs9gfm2WARMfczFnyyGRR0yMa4/PxpCeMCDCWoOKdj
         Dwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698911440; x=1699516240;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfN3ggQoi0TjXocqgo8TxZ/fpcbFAad/4kML7blXAcs=;
        b=pyRqluDdNNYWEMkFc51Wi2KtPAtpd5z3SEW8VpcKGlzP3s/upJQ9ymo6PX4v0zX60U
         3WvrylnWkpw+mEzNQARS4k+70nSHZLOuu5UA62q05tFCifZEq5xDovL9M4jbKfj3Wn1f
         c72zxJ1vUCn77ELTScOmVNKj4Gt2jynPyvFgck8UVeOetMZwxSLAcXnWm9pVYZs7kPs3
         Nc1+cvt9GcEZIOYv1v8D8fbv60VUHHS+YDXDz6ztEfLsme1yLqtsE3miX1Cugj4Uur3Y
         Ugec3QnO0a3BE9caVW9v4WIPFRGzo4E+DJ0QVpCylu5Htz0yk8My7GmHcqFMjp7dRtYN
         S56g==
X-Gm-Message-State: AOJu0YzV8Am2XkAJiVBi5QUG6gE88gUhe7fj4ThiIkyTl6YVr1+bkq65
        eZshMdxt1BfwAHvhUyVCYowQaPXfkj5S+rL0eqc=
X-Google-Smtp-Source: AGHT+IHDxevC+5zWsuUeREVbToPnJWsioTIFxWqYvPirPLjjCgqVyrVyhvj7F9gjwfO3h87AB9RfDA==
X-Received: by 2002:a17:907:6d26:b0:9c3:ba22:4d65 with SMTP id sa38-20020a1709076d2600b009c3ba224d65mr4005246ejc.4.1698911439638;
        Thu, 02 Nov 2023 00:50:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i4-20020a1709063c4400b009b2ba067b37sm786506ejg.202.2023.11.02.00.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:50:39 -0700 (PDT)
Date:   Thu, 2 Nov 2023 10:50:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     linux-rdma@vger.kernel.org
Cc:     Hiatt@moroto, Don <don.hiatt@intel.com>
Subject: [bug report] infiniband/hw/mthca: ancient uninitialized variable
Message-ID: <533bc3df-8078-4397-b93d-d1f6cec9b636@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ This code is very old, but it's also very obviously buggy.  Does
  anyone know what a good default "out =" value should be? - dan ]

Hello Linus Torvalds,

The patch 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16, 2005
(linux-next), leads to the following Smatch static checker warning:

	drivers/infiniband/hw/mthca/mthca_cmd.c:644 mthca_SYS_EN()
	error: uninitialized symbol 'out'.

drivers/infiniband/hw/mthca/mthca_cmd.c
    636 int mthca_SYS_EN(struct mthca_dev *dev)
    637 {
    638         u64 out;
    639         int ret;
    640 
    641         ret = mthca_cmd_imm(dev, 0, &out, 0, 0, CMD_SYS_EN, CMD_TIME_CLASS_D);

We pass out here and it gets used without being initialized.

        err = mthca_cmd_post(dev, in_param,
                             out_param ? *out_param : 0,
                                         ^^^^^^^^^^
                             in_modifier, op_modifier,
                             op, context->token, 1);

It's the same in mthca_cmd_wait() and mthca_cmd_poll().

    642 
    643         if (ret == -ENOMEM)
--> 644                 mthca_warn(dev, "SYS_EN DDR error: syn=%x, sock=%d, "
    645                            "sladdr=%d, SPD source=%s\n",
    646                            (int) (out >> 6) & 0xf, (int) (out >> 4) & 3,
    647                            (int) (out >> 1) & 7, (int) out & 1 ? "NVMEM" : "DIMM");
    648 
    649         return ret;
    650 }

regards,
dan carpenter
