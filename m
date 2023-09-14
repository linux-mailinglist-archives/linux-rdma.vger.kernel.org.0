Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C87A0471
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Sep 2023 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbjINMwT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Sep 2023 08:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbjINMwT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Sep 2023 08:52:19 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468921FCE
        for <linux-rdma@vger.kernel.org>; Thu, 14 Sep 2023 05:52:15 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-770ef353b8fso63052585a.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Sep 2023 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694695934; x=1695300734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X0TB+m5rXA+O4Qjyi4myXskPcAwLhP/uliLCoUat7ic=;
        b=Xfd1M+HALgu8hZwqNNySEqXBWHjdeY6ze9nNGVoewx8T6X556LnaybXdBJY7wqlr7g
         H8gDW2b+7T3ADUds9bQ47PPpc1fIAu0rY4kVl1JtMW/xDnqbu4/U8sv2YF8SAPcj2OFP
         I7UJq8QrzkTyF2ZaKzcA7k3idH9P+SA+8N5VjBb59PEjs1yW4pyl43Pue4/wLKTFv/jY
         yRXGy5vG8QRRGiKD9silUp4to6MxxO2wW1QeQ3ut5PNGNbt72ca6Elo3ezLcRIh3cGN0
         C8b51rU1k2d36/Vbba9/560h9GV/+umWarDrooPJN/gMtOK0a3nKOynq9wbyDD6eD/A5
         fkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694695934; x=1695300734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0TB+m5rXA+O4Qjyi4myXskPcAwLhP/uliLCoUat7ic=;
        b=VCb61s/nWXGgyxxZkOHGFbzwP4FvPOOgkTPM6MJQiNvUksVe2jaylrTeW1hv+LDSag
         YRd19DhVuXXVjgnUtG9vSs14ouBxS6fQBiNo3CLMfdHR5H2BYW0Bo/gHgcGmsX0T4A+E
         22ZClv00bFyhF5caaAUI2NKqPjyIWput+nAl5lUb1TPO9Xp4CzgB/cIj8qtAKyC3LgqF
         ommfYEIQpa46tcGVuXedeXI06ZNrfdfThCdFNAXRvM5BruKcl3apwpHL0U8D89UwNCuM
         g6Pe6BaxWaHAprc/u0hFkPvyaFScQlYFtUPyLZA6XVlC3nRM49EDXRcQq5Ge8vO93Buc
         QJYg==
X-Gm-Message-State: AOJu0Yyzr11fcBZ84op1JRMOBLpQu7BAhKrDWf/Pbvh4G6nckl59yDFj
        DoIPgF4bmMXkwY0wWCNUwHJFlg==
X-Google-Smtp-Source: AGHT+IErwi1vX0M2vqlZK2u/+9B6mUexyvyGIjxP/pNZX/FSk4oWpi0xLY1wgfvsBuLenS4ruBjsZw==
X-Received: by 2002:a05:620a:f0e:b0:76f:d34:4510 with SMTP id v14-20020a05620a0f0e00b0076f0d344510mr6649357qkl.23.1694695934445;
        Thu, 14 Sep 2023 05:52:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id w13-20020ae9e50d000000b0076f02a91fa8sm445359qkf.52.2023.09.14.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:52:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qglpM-003jRB-C2;
        Thu, 14 Sep 2023 09:52:12 -0300
Date:   Thu, 14 Sep 2023 09:52:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: newlines in message macros
Message-ID: <ZQMB/MkCroFNuyrA@ziepe.ca>
References: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
 <20fb88a8-6c68-671c-7791-be1df6f708d6@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20fb88a8-6c68-671c-7791-be1df6f708d6@linux.dev>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 14, 2023 at 07:12:04AM +0800, Zhu Yanjun wrote:
> 在 2023/9/14 4:50, Bob Pearson 写道:
> > Li,
> > 
> > I see that you removed the built-in newlines in the debug macros in rxe.h which is ok by me. But,
> 
> I made tests for many times about adding newline speeding up flush messages.
> With or without new line, I can not find out the difference on flushing
> messages. Not sure if Li Zhijian found this difference in a specific
> scenario or not.
> And even without new line, after output the line, the message still goes to
> a new line. I suspect if a newline is appended in the PRINTK
> subsystem.

Kernel standard is to have newlines in the format strings.

Jason
