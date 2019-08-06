Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813D2838B7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfHFSkR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 14:40:17 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:45926 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfHFSj6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 14:39:58 -0400
Received: by mail-qt1-f178.google.com with SMTP id x22so12206779qtp.12
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QSPTbJtBV8TZzAImp+rCgpVtbZq9tdcaxRKYpVi8L7I=;
        b=aBpaojAsnpFAc7O4HFzX6N/dtEg3BOSFqep41NwkplitwkM86pwGTBxHTcGJEgjqhE
         VWK1RYTgkfbXp4qIcPTb5CmF3WfqYXqgbncM+l3wCNZ6Fm08/Sp+rPJXv+/uJgsS0UnK
         HvRfJKh7AS8MYQv8FZhM4LVbHnPjuJtkeXyBAKHz+xS3R4b2i8uheGnoFHmYLz3joSPO
         zhEx+2snGFYZ3DU+QiJLge094627xJMzLh8Br2Cr6zQ0jQotaR272RwiBQYU6u+96xzH
         iOyC8OZps1+ogy6oVf6XLgizxNopdg8hPyTb4PHiNuToPLRLP+PNzvwUrXYnnc1rsUuO
         ucJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QSPTbJtBV8TZzAImp+rCgpVtbZq9tdcaxRKYpVi8L7I=;
        b=ePpa3f4VZ+hfXcsfOnkFoJiSkmjUaepcNiRkBKMU8guoy4TL78Ezutw00A39cHG3OM
         NCPWLC+EwjOv6IrUXc+h8VJXAv908NItzuDMWPUXmGkeKFFKB8GpIgSEJXLnEjyIAaJ/
         yQmhZCQ4vMsYZ/XXFoswnFPmQRBkR/ZC8U96sJeJC95oZOxawkaiXRADah0MisQB/0Ec
         GRp/Ovl1v7s1oFhSSM1SgArLkqc8SdKt9ib5Q6Jhd/eK+k5R1QpQPKtl9CtFFW5I8ZyI
         BuCktjxJ+vTMwZWVh72vUf5lcnYX+Qu4kab/xcvaD4HtBBJX9etlCKL4YWH8tftHj8g5
         b6BQ==
X-Gm-Message-State: APjAAAVLHcLkIGgKUZBBlcGmDmbto3xNGHFWNuyp+L7bwkFVjSIuc6/N
        bpwcqv0t8Nf0sdV/caicrYfPVSZlc8E=
X-Google-Smtp-Source: APXvYqwyzpo9veSDOaSICc1cYF9LO3tlWuHDRLUPIFM6G2mwhNlD8APt3TyACe/Ep21qoxpWRTmD9A==
X-Received: by 2002:ac8:f8c:: with SMTP id b12mr4542226qtk.381.1565116797512;
        Tue, 06 Aug 2019 11:39:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z8sm36924374qki.23.2019.08.06.11.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 11:39:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv4NI-0004O2-0b; Tue, 06 Aug 2019 15:39:56 -0300
Date:   Tue, 6 Aug 2019 15:39:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ju-Hyoung Lee <juhlee@microsoft.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: rdma-core compilation failed in Ubuntu 18.04
Message-ID: <20190806183955.GS11627@ziepe.ca>
References: <MW2PR2101MB0986F5879CB967B453141E93DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
 <MW2PR2101MB098617BA469695962B163707DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
 <MW2PR2101MB0986515AF6DD01233D7D7AA4DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW2PR2101MB0986515AF6DD01233D7D7AA4DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 04, 2019 at 07:01:29AM +0000, Ju-Hyoung Lee wrote:
> Hi all,
> 
> This is Azure VM with Ubuntu 18.04, the 'bash build.sh' failed with below error. I post the required information below also.
> This is Azure Standard_NC24r VM size. So it has GPU and RDMA enabled. I don't know what it means "cc: error: unrecognized command line option '-Wcast-function-type'; did you mean '-Wbad-function-cast'?" I did not modify any file. If you need any, please let me know.
> 
> <how to repro>
> %git clone <repo of rdma-core>
> %cd rdma-core
> %bash build. sh
> 
> <error>
> root@juhlee-137339034-1:~/rdma-core# bash build.sh
> CMake Error at /usr/share/cmake-3.10/Modules/FindPackageHandleStandardArgs.cmake:137 (message):
>   Could NOT find PkgConfig (missing: PKG_CONFIG_EXECUTABLE)

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Isn't this clear enough what the problem is? You need to install
pkgconfig to build.

Jason
