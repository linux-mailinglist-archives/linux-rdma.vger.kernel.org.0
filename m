Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736DF3F3EE1
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Aug 2021 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhHVJle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 05:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhHVJld (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Aug 2021 05:41:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC64F61262
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629625253;
        bh=QXBaOhATXYrFkSeHUCyv97e/Nx4nJ//xyntHaWK+ARU=;
        h=From:Date:Subject:To:Cc:From;
        b=CpIoA9KFEtCituOTOk+BErL5c4s9jVXgph9dAMs1Vnc58QN/ZX9HRxBPe05bgsOtD
         lwY163DhCjZEJekJSAkekYiqi2+CYLr584C2QGAdbT0/cmGWGqm/FKYJPETzgEgbu8
         Cr1fUpCi+8aVvO17S4+neVVCzyUCCv60hO5T4dVEX0GTbx+9Th2WljJKAF4w1wCBQZ
         Q7gT4ZAYWz4a/dOajPSh9SR1Qn8hktgFrreklVk9sovk22REqk7X826Iy4Kgyf6/Ia
         44Voy9Z4h0oQlcUHqY37DqD2IqcYx7IGfJ6euE9tHqr/7mla4OueIpKauFOIcbPDQQ
         It2VR0m/P/2xQ==
Received: by mail-ot1-f52.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so27337006otk.9
        for <linux-rdma@vger.kernel.org>; Sun, 22 Aug 2021 02:40:52 -0700 (PDT)
X-Gm-Message-State: AOAM532STU/x0QLOruFZ4YP2FKxT4LTmKF9On3c60+ALqvSbNOdD/onV
        mpeR0xEKZp3PX+gJtKcLht4hCUmlelBFDLZ6dpQ=
X-Google-Smtp-Source: ABdhPJypL3jeHlKBPOc7mZeh1vydSDdFeDt2so+noiv/NMoseeFR1Osvj6rSGnFN6yGjv45dFJbMdtLBUMNFNLyYYwg=
X-Received: by 2002:a05:6830:614:: with SMTP id w20mr23655936oti.145.1629625252329;
 Sun, 22 Aug 2021 02:40:52 -0700 (PDT)
MIME-Version: 1.0
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 22 Aug 2021 12:40:26 +0300
X-Gmail-Original-Message-ID: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
Message-ID: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
Subject: Creating new RDMA driver for habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

I think that about a year ago we talked about the custom RDMA code of
habanalabs. I tried to upstream it and you, rightfully, rejected that.

Now that I have enough b/w to do this work, I want to start writing a
proper RDMA driver for the habanalabs Gaudi device, which I will be
able to upstream to the infiniband subsystem.

I don't know if you remember but the Gaudi h/w is somewhat limited in
its RDMA capabilities. We are not selling a stand-alone NIC :) We just
use RDMA (or more precisely, ROCEv2) to connect between Gaudi devices.

I'm sure I will have more specific questions down the line, but I had
hoped you could point me to a basic/not-too-complex existing driver
that I can use as a modern template. I'm also aware that I will need
to write matching code in rdma-core.

Also, I would like to add we will use the auxiliary bus feature to
connect between this driver, the main (compute) driver and the
Ethernet driver (which we are going to publish soon I hope).

Thanks,
Oded
