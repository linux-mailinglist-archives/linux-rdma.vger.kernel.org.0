Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4085B1551C3
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 06:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgBGFSO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 00:18:14 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38760 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgBGFSO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Feb 2020 00:18:14 -0500
Received: by mail-ed1-f50.google.com with SMTP id p23so1052680edr.5
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=kiaH+EUM9IdqSdQdusqIug3qrqmSz4xmRRIeEn/wo7c=;
        b=z2O0Y+v1XqUga/xk/U5K9qnkHCKCggnp0uaXP1RiTX6DS6fNK2xHCR3Y04966tpYgm
         OvjHwZy6rzdoGYgjGb/basL3PRw+zkBnCr6SQnamYmDuFaEyIs+G0QhrLo1HhnSxEj+l
         OO/G91i3zcSsP4adlHM8xhJReBCgn08bSIMvwtnJf5RqpuDf7nOXe66ai1vDaMmre3WK
         RK1ugPUx3XaQyDUo51zShWeb5N1K2n0brw5LWkI6AsW85YXwtp35WXfHTWs/TJOyFbRs
         S+XY8WOQpCZUqxwHBeL/ETUkpqgi2/fp+1o7QcJIz3MO1eJ5sN67jisuK9rVfxTMaHrr
         SNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kiaH+EUM9IdqSdQdusqIug3qrqmSz4xmRRIeEn/wo7c=;
        b=nr8gfgN+dNmuSV1QcrEVqHMjcgAmTxTDpSxiV67K5uKDpD4JAMTgqrSI40164F5H68
         uxCPBddXTU8ZcJ0l9szHn9Oqod/nV2nRY1uUAF3i4/C6LwSdK3+bd4Oj6uM817b/LGrZ
         yfH3RVvsfOMbhcM3Jy/Jq+umkxh+mSucDsFGdqmTeFQpypyCVDxH1OtHGda3BpZ9zFxF
         6l2rVtZE4uNheVYnpDSHgn78B6idgvB1W4p7ExiwQwiGYBdwTnTO+HVql/bWHuaj4235
         kiiFTqz1n6WkUL4oXT5fxgOGRpdknKaoerWKT2CVGNGtQzPQrIA5FM6d9FJCayxFAKpx
         +cVw==
X-Gm-Message-State: APjAAAVlB4RN+BtTcxyxqNyIpCDIspauib785Xofv8wyk3MB8Xxw6RpS
        Z2Gtpr9hceWrCsdNR8SD86tzlBMR+Ru1Y771o7IpArLg2xg=
X-Google-Smtp-Source: APXvYqzkVPX9M6GR+sbSLQI7gFvG6u24wP9OcKiQz3QVDuvxN1ML7o2i7iVFRejZbF24qOcCFtJYdl9TnXjzwdErluE=
X-Received: by 2002:a17:906:eda9:: with SMTP id sa9mr6686960ejb.297.1581052690783;
 Thu, 06 Feb 2020 21:18:10 -0800 (PST)
MIME-Version: 1.0
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Thu, 6 Feb 2020 21:18:00 -0800
Message-ID: <CAOc41xHpF5VXK_-L_BeaU9v842BuRd2QTXkZunDKDgiEhixFtg@mail.gmail.com>
Subject: maximum QP size
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I'm running the ibv_rc_pingpong example and I notice as as rx-depth
increases the QP create fails, eg at 50k. My understanding is this
variable controls the number of RECV WR that will be posted in advance
before SEND WRs are posted.

Is there a limitation on the queue size (the size is unit32_t) and if
so why ? Also is there a way around it ?

Regards
Dimitris
