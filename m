Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889601E5238
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 02:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE1A3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 20:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE1A3H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 20:29:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC1C05BD1E
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 17:29:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id be9so21765193edb.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 17:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=aO/SngNHfFkwTADCKbGKV4o2+E9bek8s3yykrCMSRT0=;
        b=F8vFwLAemEeWC8gvCHuwRrDRfaj1L8Psh43WhFoS9LPMiPgsrR+a8PtwQ51fNjeR/f
         rwkZv9zqV8qfKj2b2PFUNPZPck3xz3Zk0qyHyNAO6aG7mkksxsxpuIdseMk7Y5cec3CT
         x7tegVvmf+GhoMc30Tn5rIVWmK8h5/fYPcvRMEl1oHK31lfYS687BGM5RnoSLaqCyxIY
         G5EodJd2HPR2Hmd2ApZ/U9CQdb8tyrDnzACBLZRJw3q4Diov3ipgdHb4Vxv7EIGuwzaO
         JEqwJxCGH66BnOvhtwS3CVvao/pO0RcCeHxKTHHuNOWziOEW0rLgYF2x9kGVLtXcdoIV
         0hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aO/SngNHfFkwTADCKbGKV4o2+E9bek8s3yykrCMSRT0=;
        b=iel/Q9C7a/+ruVZ2mE3J8qeYvj0TMcRPPlx6JJYKIRt4kW52ZvH3UdkmLjvaQC0suP
         K460jp9nhZWaNI9PDENJRIPq4ZthMX4ioJ/jFeaBgryvXBBpYCY7J9sUoyIqY7W3nUDh
         Rkr23auGfk66sB9EOFk3/x2PA1v8ayBbjRVeSBBo74rb3+QjIlwcHGU3H1loakV+PI8w
         dHYQ/bGnxFNOh22KSRq/3OjgRuEb5UpiOKX4V19fiWbbLPeudcvk/nY7/EK0irq5xDig
         VB5Fz5P7MOQyZ7K9zKWsd/w4EeIACwrPOGUgFSNL5xwEdTm5xoPjFanCdNEUhcxrKdi1
         YSfA==
X-Gm-Message-State: AOAM531MKUURAVyrr8pw3s8dyGGE+JD8Bto/MJWLfVJeUA+F3x6j7BFl
        Azu0w+d2cSM4PcUWEgu1vijmsp/SAElZpxzg0DLTfin8MH/loQ==
X-Google-Smtp-Source: ABdhPJzTub0w38/d83srKTzCooRnqyXSvwM+z/iZaLRnHAet6NNxdqhmhQYspUk5AaLKU9mrcWLXg/NE98Pk9zuICvY=
X-Received: by 2002:a50:f182:: with SMTP id x2mr628224edl.336.1590625745137;
 Wed, 27 May 2020 17:29:05 -0700 (PDT)
MIME-Version: 1.0
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Wed, 27 May 2020 17:28:55 -0700
Message-ID: <CAOc41xFrFtXzJcJPZXm6g-qRmkQAb84f-PNwhsYbiqDhydJXhQ@mail.gmail.com>
Subject: read/set the RoCEv2 UDP source port with libibverbs
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I'm trying to send data from an embedded device to a Mellanox
ConnectX-5 without the RDMA connection manager (libibverbs only) using
RoCEv2.

In Annex 17 (RoCE v2) page 21 it implies both transmitted packets (eg
SEND FIRST/MIDDLE/LAST) and receiver packets (ACK/NACK) must have the
same UDP source port:

  "Consequently, RoCEv2 endnodes set this field so that packets in a
sequence that has ordering constraints (e.g. packets from a connected
QP) will all carry a constant value."

It's unclear whether this is a strict protocol requirement but I'm
trying to access/control that parameter that the card selects to
transmit ACK packets to the sender.

Is there a way to do that from libibverbs ?

Thanks
Dimitris
