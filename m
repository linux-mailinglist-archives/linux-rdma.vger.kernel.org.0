Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19D2325AF
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 21:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2Ty7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Ty7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 15:54:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BCDC061794
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jul 2020 12:54:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f24so5096899ejx.6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jul 2020 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FLdcQvbATlWGb3q817mpG8Q2+i83wVtJgcYRlPT/aYA=;
        b=pOJlWJXwH6c6O0LH7qnIGFn0B3hvpBeLuUn6vkv/MlC4v53HPWF5Anl9iPthvkHeOm
         dk+G7De1InWq4U+AzRXZZ0F70RNDudZAYyMPx57lipYMNREeHbtOjmLntVfZZOMqutOG
         RERzqE0jGTHzr5A3Rn+iTpvpuUEyOIJJgmoCGR9eC+zpPbvdMdGQtmRd5JG54pRl6Z2X
         If5emn5CpwamIP5wblzQ+cC8ZO9qZpeSMdm/8DLzZwcOuCAH8XnNrimmpD0kh4mh3cg3
         vPYabDVohic3+8Pc2zYt0IFEb+Qgg8Y3M6SgwTZX37JCy1HjYzBfuyiLlWSoRJf++VUj
         lIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FLdcQvbATlWGb3q817mpG8Q2+i83wVtJgcYRlPT/aYA=;
        b=MpEDEHSBFyxSzq7GhSJ8klMB9/rtIILj7OctJdziyWI6I51YN4H+3ycZucPSMSWZaR
         jYQNqc+PmJDp5HhPEKk9x6qmA+8GCmdYDSEvLZf4F37XoEe5fN67t+4OW0DQlDOUuH1c
         RweMoAcIlcczqSxNgy3NwmfCcH/A8YKS5pDOl38CCQimmD1BX3Fa9+QH2tYjlxuzncKk
         6BIQGehs2Et9XBDQgMymzQSjpv5tarlZ6H9iyVDA1AOckigwV80F7VTZHYf143Va8rjR
         VXuqCoGkVMt/DT/7WpNgrPwVb07Xyn7BbzDWIWTueVDKsNvq1HYSo+wEBQ9Jbm9+rfu8
         zaVA==
X-Gm-Message-State: AOAM532oH3+70n1+BhPaa1egu9x5HguswIOTeKkofRZO38JrDursq2es
        Go9JNwrcXRayiMsB51rQRFD4A+xnNffanY5/7vfSf3LAqNU=
X-Google-Smtp-Source: ABdhPJy0gCXT/ffukSs9if5KM16jklVYmn/qOuKfctfPuBS1jc/oUBj465t8J4OCiz0Noe9WegKMXNvT1m1ulILOiVE=
X-Received: by 2002:a17:906:3614:: with SMTP id q20mr27956ejb.142.1596052496986;
 Wed, 29 Jul 2020 12:54:56 -0700 (PDT)
MIME-Version: 1.0
From:   Anubhav Guleria <anubhav.nitsri.it@gmail.com>
Date:   Thu, 30 Jul 2020 01:24:44 +0530
Message-ID: <CAFsMY+gFTh_hUDGexx3duLD_anZkar+SNj3S9UhMYH+ciYU-rA@mail.gmail.com>
Subject: Issue with i40iw
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
Both of my servers are running with kernel 4.14.178 and have Intel
Ethernet Network Adapter X722. Also the IOMMU is disabled. I was
trying to run qperf and ran into couple of issues:

1) While running any bw test, eg. rc_bw or rc_bi_bw, I see following
messages in dmesg:
i40iw_cqp_ce_handler: opcode = 0x1 maj_err_code = 0xffff min_err_code = 0x8007
i40iw_wait_event: error cqp command 0xb completion maj = 0xffff min=0x8007

2) Following rc benchmarks fail: rc_rdma_write_bw, rc_rdma_write_lat,
rc_compare_swap_mr, rc_fetch_add_mr, ver_rc_compare_swap and
ver_rc_fetch_add. For these I get error of failed to post "benchmark
name"

Am I missing something here? Any suggestions?

Thanks,
Anubhav
