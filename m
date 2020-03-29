Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F769196FCB
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgC2UCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 16:02:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39858 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgC2UCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Mar 2020 16:02:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id f20so13414071qtq.6
        for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2020 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eHbbFfkkFhXCO02Nqmfb+0Wi67CjOGnMXvMU83fazlY=;
        b=j8hcpZZksr/SesklTFVI0HJZ3TFxuHUqsUnPtf2yvFgJSNT8Yn3N08uTnevHNbb4qx
         Edw/5WAeLJSLuNMnIdQQtPcNX+OyiT+K0NwRUyrbo72zEDI7n6d5Jwy9Ztshw53/IK35
         3Uz/7qNka5lCJwXAhg70MNicUrC4ggntbcOdXGn4wMAVcNF6o/llIuZB2O4a8BqrqTeR
         CrxIRFeMfMzNUnqOS9JkUNTtVYvWDE+6h97uayaQkA7s2zqx2kkT/Y6u6gRweDZWaHw5
         NKmot5xTUGXL7P/FiDKyQCbc7IGp9g5SnMuPLEhTSfx071L3q/4aMVyyJv9vuBKDxSDM
         6WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eHbbFfkkFhXCO02Nqmfb+0Wi67CjOGnMXvMU83fazlY=;
        b=dIaozMuyiL8LLQeWQX9FDJWNGL2th4apVKp8bqm9gpRWiV4qhnyghPbDPUo2oSN3gm
         OwlpPH2VOato+V1ZmiRgzFh4AIKjbGe6jKMqJi+I7/dP08SNcWyi/Bs1GHLc44JcwqZT
         QxH63jk8bdDNciX3DhArrB1JX4OAUX+Cu6QR1481OmdWNzW5bpS78HIyNKMC7nQatLr4
         QJXn0+j5WfTZMZcoPwq7bUou/CoaSd+cqGXmXN/4S7TD06gPxWPF6r9Sxzb/oUhxOt8C
         K9PeSnjF7CIbBvEFYcE5XyOxS/LKhT4LgUMsypV8Bg0dESv33Tx4IenioYMSYYImiFZi
         F+Jw==
X-Gm-Message-State: ANhLgQ2ZPa6DwcCNVSIC8kAX3q3BOro5Yi7HlaLezrssGdwpEeGUPO+z
        o17hlAR0Q5oIQZlaH0l2AGnJxA==
X-Google-Smtp-Source: ADFU+vuHk82tQtOVfxNoh1i0Z0moEB3sESTia/9rZjRN0BRDc2HZtWG6P424Rmx6ByTSQB5ck2nXVA==
X-Received: by 2002:ac8:dcf:: with SMTP id t15mr3942442qti.336.1585512134499;
        Sun, 29 Mar 2020 13:02:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v187sm8455341qkc.29.2020.03.29.13.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 13:02:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIe8L-0002nf-8Z; Sun, 29 Mar 2020 17:02:13 -0300
Date:   Sun, 29 Mar 2020 17:02:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH v1 42/50] drivers/ininiband: Use get_random_u32()
Message-ID: <20200329200213.GG20941@ziepe.ca>
References: <202003281643.02SGhN9T020186@sdf.org>
 <OF05D43316.2F69D46F-ON0025853A.00513FE8-0025853A.00528B66@notes.na.collabserv.com>
 <20200329165204.GC4675@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329165204.GC4675@SDF.ORG>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 29, 2020 at 04:52:04PM +0000, George Spelvin wrote:

> Many intra-machine networks (like infiniband) are specifically not 
> designed to be robust in the face of malicious actors on the network.

This is not really true at all..

Jason
