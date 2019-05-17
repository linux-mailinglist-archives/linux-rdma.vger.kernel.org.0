Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3145C219A7
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2019 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfEQOOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 May 2019 10:14:25 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:54953 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfEQOOZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 May 2019 10:14:25 -0400
Received: by mail-it1-f171.google.com with SMTP id a190so12155578ite.4
        for <linux-rdma@vger.kernel.org>; Fri, 17 May 2019 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=f+j0xcuszY5wos999vSeiGBMMPgDdLTNtBSiZMwi680=;
        b=p0B5tgU4T2wjO4LmcUCnOK6OZ2crUq9NNgOb05w5I/7t2WGV5Ai4dbkdMAC6qhjCzq
         2sqmOLrVHCk1BU2Jld+qORbylFFyHqrPhbucbO+bWKp3ZEh7yhhvJybja5TGddA9Vj5s
         F5+fJ0T2ZabFtXZeBSFoz6rYjMMGC4k4F7dF/AaUsug1GCHBdGYJ77R22i8Ol4cJX4EF
         p5lFQNOWi6PWTYX+C7KU2uCkpetq6Zh6/L+a458JvpvlEI1gSisnTjEZZTCuAlWwgsZ/
         W5xXhMMa+cGm534weWVk+VmiIo/CntWHFUCI2n1oAhk9vXXV6uUgBgGV84EPPtoGkxaj
         /kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f+j0xcuszY5wos999vSeiGBMMPgDdLTNtBSiZMwi680=;
        b=udzba94wYmqUhxamFSuGv+KPuJFsxAacJ295QbM+ueC4GWXplFGCzSES7rvFCWKP22
         Om1U8Zpm3b2P/tKQlnSqWrHqH7/Uc46yJgKYyxl+JuA8GSL4+u0dwOE5DMK4THKbKX6k
         kZReR832+rKy9tRLf77M1kUprBzHOWwFz2oWdbT9Y8f1HzxewsOutRzcTDK2XSedvb4Y
         8wMF2Sm+OrbOeqta2ToTqBjESUULkmPa4beEQzjUiafdDW7J3jpYvCnHh/DvWN9i1Hnv
         jpXiyC4Xu37cOljrA1gFK4WiK53QuAWsQSAIaC5ZYtjxL4wpSm0750kncVKM1JkVu8Ts
         ju9w==
X-Gm-Message-State: APjAAAULByQ2hspye9uE07tWLdmN7wV1uQkELHZBAIvp0TgeRJEWcUa5
        N01IXKV5pnV7ZHZ+avhaX6JmSedhzKrD86XTqvpKaw==
X-Google-Smtp-Source: APXvYqxDOZ7BQDXVRGYBp16+3jwx7RZRelHEaNlxfG4NymsaiXJrmV6v1RbmSdf91OT+U4n0BfTs2UKUuIc/2ci1PdE=
X-Received: by 2002:a02:ca4a:: with SMTP id i10mr10790926jal.70.1558102464293;
 Fri, 17 May 2019 07:14:24 -0700 (PDT)
MIME-Version: 1.0
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Fri, 17 May 2019 09:14:13 -0500
Message-ID: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
Subject: rdma-core debian packages
To:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey,

Is there a how-to somewhere on building the Debian rdma-core packages?

Thanks,

Steve.
