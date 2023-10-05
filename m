Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24D7BA40E
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Oct 2023 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjJEQEy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Oct 2023 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjJEQDR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Oct 2023 12:03:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB26C7FF2E
        for <linux-rdma@vger.kernel.org>; Thu,  5 Oct 2023 08:56:23 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-419c16a4209so14069031cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Oct 2023 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696521382; x=1697126182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uG4Ph64bewzJVU49JFBslaTgnXwJjaVRqO+mHvKsins=;
        b=eRC9OuOnWgE+5IHji7P/SGFXu3/zgLv+Atumhq0U01RmN6egXpJ+BVP6jLMm9Lk6Gl
         jYPQ470ltD0wuJrLWDC2wE1WKNlsdahmUjbHSggzwmCZW4vm5CjK/FBaXZTZPX8WGDzl
         QJJrIp0OXFD3pO5sek6BH5Ge4PKkAeGqRIZm78FU1YRzHwNfymUPySUadOxjsHp4+Pdl
         M3urN58FveKpLomrfDQLS5ryHM3DCcv3QruRoP6Ibb6mXJhHeh1JMj6C9oATkwA+qcjX
         BBf4ry4GvLPPbwI6FI4TcIMkLHjk1j7IyuKKn+WHgS5cuQsr/RlVUbRbB/4GYorh55k2
         mcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521382; x=1697126182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG4Ph64bewzJVU49JFBslaTgnXwJjaVRqO+mHvKsins=;
        b=UbvdrJgw1ltvRPYtrKOn0jiBK2xErEcDA5GsICsP5rHqx3WZjVyDGZYgoV33ZACAkd
         H9HELbjvVvIjhRzjARyTLvAbZmPu1vPeFGQt/PdSANMQBKlUMgAQsuVNv5bLHrZtXpoi
         pJdJqBpiJmspgqeu7VZ8P9qSfdYhTECqVcDZ/OS907+mgaYzbLPbMc0ARIksCzwWDNAW
         Jm8QAOxZazaqruv6T/AE2EcIDhVDyTJ/02nYvdUECr889YtLK+nBiI8BsXYX3o3gpyXq
         c2PhVns35JzoNcYMyPvEkzHfjNrC01xGGYN5E//2LP5T7OfH/tLms99/EYBLP5ec3ld2
         oCdA==
X-Gm-Message-State: AOJu0YyuYXnIfBC33UMSDjN0pXt22mKtqB+VaqyMHt910mSmGYABVnVw
        YtNSCpPMEOu9bfMH0/2fijEYYg==
X-Google-Smtp-Source: AGHT+IGWO/x3ytUeLf5AFCkVaB7RnAy+uiwHbX9L5BgFMBqhYq0K8pe3itPgQK5suUVO326lMXZwpg==
X-Received: by 2002:a05:622a:14f:b0:417:fe21:b254 with SMTP id v15-20020a05622a014f00b00417fe21b254mr1562596qtw.18.1696521382422;
        Thu, 05 Oct 2023 08:56:22 -0700 (PDT)
Received: from ziepe.ca ([142.68.26.201])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87ed8000000b004181a3eeff4sm572363qtj.5.2023.10.05.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:56:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoQi0-0045ZW-1M;
        Thu, 05 Oct 2023 12:56:16 -0300
Date:   Thu, 5 Oct 2023 12:56:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, matsuda-daisuke@fujitsu.com,
        shinichiro.kawasaki@wdc.com, linux-scsi@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231005155616.GR13795@ziepe.ca>
References: <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 05, 2023 at 07:50:28AM -0700, Bart Van Assche wrote:
> On 10/5/23 07:21, Jason Gunthorpe wrote:
> > Which is why it shows there are locking problems in this code.
> 
> Hi Jason,
> 
> Since the locking problems have not yet been root-caused, do you
> agree that it is safer to revert patch "RDMA/rxe: Add workqueue
> support for rxe tasks" rather than trying to fix it?

I don't think that makes the locking problems go away any more that
using a single threaded work queue?

Jason
