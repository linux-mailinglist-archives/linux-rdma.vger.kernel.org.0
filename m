Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32144B349
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfFSHpE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 03:45:04 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:51916 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731065AbfFSHpD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 03:45:03 -0400
X-Greylist: delayed 738 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jun 2019 03:45:02 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id EA326814;
        Wed, 19 Jun 2019 09:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1560929562; x=1562743963; bh=OclQqLg+8U1JWonW5RZbtfoMC1IimdHslWy
        HSQ7fQyE=; b=CnCHi1dULXFOSiKbj4SXp5nclrnSB3UnxRfdOdBDNkij5x7P92i
        W4HiyJu2IVAQPxlKFNP95Yru/HiRfO+L+JlhDcghk+a8ctYVVySnPz5mLe1BMydN
        eg4qMFEIQXc3KhsfoY2pVjmh05RuzullHWWbXya8A9zwcFbXewWPN6aahs3Lp/OF
        o+GYVMr/1jpLACMdP/bQwsooA7NkLUl9zoj+tQAfgEN/5mnP4uuqAb8oLZd2Ac9q
        z8A/ESq7aBjFgsklyvcwm9z4HIVjuMqQv2TRZD4jw/BsbPwOMikKChsqTf8vqiz9
        dYfFujaVSYPvWj6dnZtalee8TygqJIRbg4tgB3T9km9q8WkktM+Fbm3DNcL1mkqh
        BU8IzHhYQSLZLywtasR9k4Pk2mgoBhXfFZzgWU8ZeCTJgQhvKcwhnlaYIsOLLT2r
        5I8NjYvhnY9CzILS6yiPqedSSbnFa9k1tqS7baQ3K0uOcbRVKEkXzcUQNLzf1Qr3
        oW0XZrLpOIqIlIgVB7t0aYnLgcZu88d7LAAP02bfHFq9Xiue0z9a1neF5odrNl5x
        Kg8OsT5TOvRV6p4b2mnr3V3LxsmwWzsTUTze5zwWz1en9Sf79k1vQEysgniV7J68
        eDs8mLJqHijGPKBo/IjuFnUkTefCNXQt6oz6wb/K68sh346dLCkaqOFc=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5gHneNcaTfjr; Wed, 19 Jun 2019 09:32:42 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 96203635;
        Wed, 19 Jun 2019 09:32:41 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 25BC835D3;
        Wed, 19 Jun 2019 09:32:38 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1 02/22] docs: ioctl-number.txt: convert it to ReST format
Date:   Wed, 19 Jun 2019 09:32:14 +0200
Message-ID: <1723505.IrfYrSHNLM@pcbe13614>
In-Reply-To: <e8f1c925c5d118717eb38455e8f9dacf340cc35e.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org> <e8f1c925c5d118717eb38455e8f9dacf340cc35e.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tuesday, June 18, 2019 11:05:26 PM CEST Mauro Carvalho Chehab wrote:
> The conversion itself is simple: add a markup for the
> title of this file and add markups for both tables.
> 
> Yet, the big table here with IOCTL numbers is badly formatted:
> on several lines, the "Include File" column has some values that
> are bigger than the reserved space there.
> 
> Also, on several places, a comment was misplaced at the "Include
> File" space.
> 
> So, most of the work here is to actually ensure that each field
> will be properly fixed.
> 
> Also worth to mention that some URLs have the asterisk character
> on it. Well, Sphinx has an issue with asterisks in the middle
> of an string. As this is URL, use the alternate format: %2A.
> 
> As a side effect of this patch, it is now a lot easier to see that
> some reserved ioctl numbers are missing the include files
> where it is supposed to be used.
> 
> PS.: While this is part of a subdir, I opted to convert this
> single file alone, as this file has a potential of conflicts,
> as most subsystem maintainers touch it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../{ioctl-number.txt => ioctl-number.rst}    | 588 +++++++++---------
>  Documentation/process/submit-checklist.rst    |   2 +-
>  .../it_IT/process/submit-checklist.rst        |   2 +-
>  .../zh_CN/process/submit-checklist.rst        |   2 +-
>  include/uapi/rdma/rdma_user_ioctl_cmds.h      |   2 +-

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

-- 
Federico Vaga
http://www.federicovaga.it/


