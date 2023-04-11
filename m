Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE56DE19F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDKQ4s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Apr 2023 12:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDKQ4r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Apr 2023 12:56:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4134E2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 09:56:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n14so33573768plc.8
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1681232206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxsrhFr9gAcsDYzHDMqgdxz66lr992pXpsYG+TYn7BY=;
        b=Y720tfUEkWviVRs6mS7V+Vn2Ipe9PLy0yoXyLcXnNy9VCIRB+7azrlXzFv4kX+7NaO
         Esq3aAkSANY5Us4No/o1926od7eLIEzcoZ+OFog/BUeFrYQeVuw4fuRhBulgPJcEaFYH
         U7ICMBtqKwO1F50hm/ILtE2fnMu/QEnymX+VkG7cMBlhfgv4vhpGc/idjQ1EirBn7wlg
         VozRZLkAvrG2bWXvY5B/xC5i1v1G3Lnojsfebaz5enxqfiyu0IOLfE9/3SRRQ1+yHe10
         NEY9LGClk2nUtk0LP4fYmc6Vq0HaKuwVC92z3E4u4+iUhs2KZIl1lAFoMBtC0xuot/Xo
         7MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxsrhFr9gAcsDYzHDMqgdxz66lr992pXpsYG+TYn7BY=;
        b=x1UZCuTWIjlBkuBRmiAvLYpKq8LcLnQvXtLqq0bdcOTtnsX1Dml1N3CwMVxAnckfxM
         78KUSkLKstoUIOqv8RX2mn0d0TUAweatTywPT1cXk7z+kUARCljHYvjcLbDeyr3YB+5G
         NPmzPD5vgz+dVhfO4RWxQic42+ZWl3ZhDkJqVXiP+/JGFjPUdYkOJwqatV1GM7D76oGn
         X0FrTKu3lJFyUlDBPn0SwMnKZKRym3a7qPsuaXwJf7Lz3JFIOrHibjIIv1xzbRXhamyb
         oS60ypXuYpZrSZSLqtJzyZqjZEMjq2YpTBtx6my0dQEfxlYup/+Yrywx5TapHk0GBXR6
         7ZsA==
X-Gm-Message-State: AAQBX9c/1u5zZoq6B+1RKla681unm4zLFaGzDXiTBLWc3g1tKH3hPxHd
        w21enqYWO11gTqLDN/tMbFBZzacHUPNDIWoK9JE=
X-Google-Smtp-Source: AKy350bzxdngif1tIjJpnz0fv0RyzS+deIFHJGJVnir3SSS508uYb4dBDyUff56WXoYUbDdSge5Bqw==
X-Received: by 2002:a05:6a20:4f21:b0:da:6c0b:c3b0 with SMTP id gi33-20020a056a204f2100b000da6c0bc3b0mr12605695pzb.39.1681232206338;
        Tue, 11 Apr 2023 09:56:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s15-20020a65584f000000b00502fd70b0bdsm8799004pgr.52.2023.04.11.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:56:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pmHIS-009Prz-CS;
        Tue, 11 Apr 2023 13:56:44 -0300
Date:   Tue, 11 Apr 2023 13:56:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 6/6] RDMA/bnxt_re: Enable low latency push
Message-ID: <ZDWRTDx2ZVN3NXfc@ziepe.ca>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
 <1681125115-7127-7-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681125115-7127-7-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 04:11:55AM -0700, Selvin Xavier wrote:
> Enabling the low latency push in Gen P5 adapters for small
> packets. This is supported only for the user space QPs.
> Introduce new mmap flag for write combine buffers.
> Allocate separate Write Combine pages from BAR when Low
> latency push mode is enabled in HW.

No new mmap flags.

This looks like it is basically the same as mlx5, I expect you'll run
into all the same issues and needs as mlx5 did.

Follow the modern mlx5 design, add a new API to allocate one of these
pages and have it return back the mmap cookie to use. Let userspace
allocate as many as it needs.

Jason
