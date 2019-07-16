Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2276A888
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 14:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfGPMQu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 08:16:50 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42294 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMQu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 08:16:50 -0400
Received: by mail-qt1-f175.google.com with SMTP id h18so19240565qtm.9
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jul 2019 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fEcv1Om6DU0ipc4DBzcdOBxaDjLHUwwSSVaOtqt8pAA=;
        b=TGkbwazEj6EF5hOMa7ARDPY9j8qHkfuRmKjsEuffQzJIprGBBW8/aYi+eq92gyUsyS
         57iuZpRLEX5jpyebMwUSkPZCnIX852BOCW/CjnGeigS+Kzky/3KSiWbwFRBo6A1HA6EQ
         33ebB/d+b7t8Dl5bDb+W6w77QC9z5nDw94gIkybsA9zr/YO14/bxsciLBZMUnpsLVMD3
         58zWVghruGcO+cVFJ2GG0fuClkIXxCKQBqk2kKZ9aYJfK3e4xK6f36yEkYBMfAy+27qM
         wZz/HMqrIsAWtsO1ejK8e4e08OBQI6wLTWibLRrMA3hpAMkQoGVMyAak6uCVphfpQ6Tj
         lubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fEcv1Om6DU0ipc4DBzcdOBxaDjLHUwwSSVaOtqt8pAA=;
        b=k/6xpGR32V00UOkjLZDbzhP94fFVhGbxklDJi+dPxmmFjfdAJIRlxWAz61NIxj+z/L
         OtMRhw2CiVeaZH9qU3igu3GZqonRhANOX+e1/pVQNzw317uUTkGjzRW17lAORMWObfY3
         REhTYKgzlH2X8VR24lm47YbBHcy4pZzosnjBsPW0957SYL+p90sGuDT+TgYahWLSHAIr
         9u5jfVrPluKH3j3arllY5A+/86fx8BW4S5v2o50giVFx5Y3yU0pBn9jG55Ky9+sLKd2Q
         cEgvw4n/YWumsjD8XFWtTEjFo1VehQE5C8IvZM56NfyZunNQqlG2biXVME1lclDo8IGB
         kOVQ==
X-Gm-Message-State: APjAAAXy+B73lFmmxcEM3m/Mp7clnGJ07928LdxpOWwgoANmfzhCk8m4
        ur7dssekREwrF35V6jIlkUKNuHV3S4/taw==
X-Google-Smtp-Source: APXvYqzKWMwCPTDs61vXPAUJL9LaxaZlaGSRofgOWfAuzSx7vdn2PlZqck78du44Y9QYVLoGyeigGQ==
X-Received: by 2002:a0c:eecd:: with SMTP id h13mr23568450qvs.46.1563279409281;
        Tue, 16 Jul 2019 05:16:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o33sm6774302qtd.72.2019.07.16.05.16.48
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2019 05:16:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hnMO0-00087L-Bz
        for linux-rdma@vger.kernel.org; Tue, 16 Jul 2019 09:16:48 -0300
Date:   Tue, 16 Jul 2019 09:16:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: linux-rdma now archived on lore.kernel.org
Message-ID: <20190716121648.GB29727@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For those interested Chris setup archiving for our list here:

https://lore.kernel.org/linux-rdma/

Which means it participates in all the usual redirectors on
lore.kernel.org

Thanks,
Jason
